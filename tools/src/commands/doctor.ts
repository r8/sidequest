import { join } from 'node:path';
import { writeJsonAtomic } from '../core/json.ts';
import { miseAvailable, miseCurrent, misePins, configletVersion } from '../core/mise.ts';
import { doctorFile, repoRoot } from '../core/paths.ts';
import { colorStatus, table } from '../core/format.ts';
import { observeToolchain, supportedHere } from '../core/toolversion.ts';
import { loadTracks } from '../core/track.ts';
import type { DoctorReport, DoctorTool } from '../schema/doctor.ts';

export default async function doctor(): Promise<number> {
  const root = repoRoot();
  const tools: DoctorTool[] = [];
  const problems: string[] = [];

  if (!miseAvailable()) problems.push('mise is not on PATH — install it from https://mise.jdx.dev');
  const current = miseCurrent(root);
  const repoConfig = join(root, 'mise.toml');
  for (const [name, wanted] of misePins(root)) {
    const entry = current.find((t) => t.name === name && (t.sourcePath === null || t.sourcePath === repoConfig)) ?? current.find((t) => t.name === name);
    const ok = !!entry?.installed;
    tools.push({ name, wanted, resolved: entry?.version ?? null, ok, source: 'mise' });
  }
  if (tools.some((t) => !t.ok && t.source === 'mise')) problems.push('some mise tools are not installed — run `mise install`');

  for (const track of loadTracks(root)) {
    const tc = track.quest.toolchain;
    if (!tc) continue;
    if (!supportedHere(tc)) {
      tools.push({ name: tc.bin, wanted: tc.version, resolved: null, ok: false, source: 'toolchain' });
      problems.push(`${track.slug}: ${tc.bin} is not available on ${process.platform}; it runs on ${tc.platforms!.join(', ')} (see tracks/${track.slug}/docs/INSTALLATION.md)`);
      continue;
    }
    const resolved = observeToolchain(tc, track.quest.test.env);
    const ok = resolved === tc.version;
    tools.push({ name: tc.bin, wanted: tc.version, resolved, ok, source: 'toolchain' });
    if (!ok) {
      problems.push(
        resolved === null
          ? `${track.slug}: ${tc.bin} not found on this host (\`${tc.versionCommand.join(' ')}\`); see tracks/${track.slug}/docs/INSTALLATION.md`
          : `${track.slug}: ${tc.bin} ${resolved} is installed but quest.json pins ${tc.version}; ${track.slug} tests will not run`,
      );
    }
  }

  const version = configletVersion(root);
  if (!version) problems.push('configlet does not run through mise — run `mise install`');

  const report: DoctorReport = {
    checkedAt: new Date().toISOString(),
    tools,
    configlet: { ok: !!version, version },
  };
  writeJsonAtomic(doctorFile(root), report);

  const rows = [['tool', 'wanted', 'resolved', 'source', ''], ...tools.map((t) => [t.name, t.wanted, t.resolved ?? '—', t.source, colorStatus(t.ok ? 'pass' : 'fail', t.ok ? 'ok' : t.resolved ? 'mismatch' : 'missing')])];
  rows.push(['configlet', '', version ?? '—', 'mise', colorStatus(version ? 'pass' : 'fail', version ? 'runs' : 'missing')]);
  process.stdout.write(table(rows) + '\n');
  for (const p of problems) process.stderr.write(`✗ ${p}\n`);
  if (!problems.length) process.stdout.write('✓ everything is installed\n');
  return problems.length ? 1 : 0;
}
