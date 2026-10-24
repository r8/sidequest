// quest new-track <slug> --language <Name> [flags] — a configlet-lint-clean Exercism track with a
// hello-world exercise and a quest.json. Defaults are the Janet shapes.
import { existsSync, mkdirSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { parseArgs } from 'node:util';
import { ATTRIBUTION_FILE, attribution, setAfter } from '../core/authoring.ts';
import { PALETTE, fallbackColor, nextColor } from '../core/colors.ts';
import { QuestError, usage } from '../core/errors.ts';
import { display, repoRoot, tracksDir } from '../core/paths.ts';
import { capture } from '../core/proc.ts';

const JANET_TAGS = 'paradigm/functional,paradigm/imperative,typing/dynamic,execution_mode/interpreted,platform/linux,platform/mac,platform/windows,runtime/standalone_executable,used_for/scripts';

export default async function newTrack(args: string[]): Promise<number> {
  const { values, positionals } = parseArgs({
    args,
    allowPositionals: true,
    options: {
      language: { type: 'string' },
      ext: { type: 'string' },
      solution: { type: 'string' },
      test: { type: 'string' },
      example: { type: 'string' },
      runner: { type: 'string' },
      blurb: { type: 'string' },
      tags: { type: 'string' },
      'indent-style': { type: 'string' },
      'indent-size': { type: 'string' },
      author: { type: 'string' },
      color: { type: 'string' },
    },
  });
  const slug = positionals[0];
  if (!slug || !/^[a-z][a-z0-9-]*$/.test(slug)) throw usage('usage: quest new-track <slug> --language <Name> (slug: ^[a-z][a-z0-9-]*$)');
  if (!values.language) throw usage('--language <Name> is required');
  const indentStyle = values['indent-style'] ?? 'space';
  if (indentStyle !== 'space' && indentStyle !== 'tab') throw usage('--indent-style must be space or tab');
  const indentSize = Number(values['indent-size'] ?? 2);
  if (!Number.isInteger(indentSize) || indentSize < 1) throw usage('--indent-size must be a positive integer');
  if (values.color !== undefined && !/^#[0-9a-fA-F]{6}$/.test(values.color)) throw usage('--color must be a #rrggbb colour');

  const root = repoRoot();
  const dir = join(tracksDir(root), slug);
  if (existsSync(dir)) throw new QuestError(`${display(root, dir)} already exists`);
  const ext = values.ext ?? slug;
  const language = values.language;
  const files = {
    solution: [values.solution ?? `%{kebab_slug}.${ext}`],
    test: [values.test ?? `test/%{kebab_slug}.${ext}`],
    example: [values.example ?? `.meta/example.${ext}`],
    exemplar: [(values.example ?? `.meta/example.${ext}`).replace(/example(?=\.[^/]*$)/, 'exemplar')],
  };
  const runner = values.runner ?? slug;
  const config = {
    language,
    slug,
    active: false,
    blurb: values.blurb ?? `${language} is a programming language.`,
    version: 3,
    status: { concept_exercises: false, test_runner: true, representer: false, analyzer: false },
    online_editor: { indent_style: indentStyle, indent_size: indentSize },
    test_runner: { average_run_time: 2 },
    files,
    exercises: { concept: [], practice: [] },
    concepts: [],
    key_features: [],
    tags: (values.tags ?? JANET_TAGS).split(',').map((t) => t.trim()).filter(Boolean),
  };
  const color = values.color ?? nextColor(trackColors(root));
  const quest = { runner, harness: [], test: { argv: [runner, '{test}'], env: {}, timeoutMs: 30000 }, toolchain: null, color };
  const docs: Record<string, string> = {
    'README.md': `# ${language}\n\nAn [Exercism](https://exercism.org)-format track for ${language}.\n`,
    'docs/ABOUT.md': `# About\n\nTODO: what makes ${language} worth learning.\n`,
    'docs/INSTALLATION.md': `# Installation\n\nThis repository pins ${language} with [mise](https://mise.jdx.dev): run \`mise install\` and \`npx quest doctor\` from the repository root.\n`,
    'docs/LEARNING.md': `# Learning\n\nTODO: links to the best ${language} tutorials.\n`,
    'docs/RESOURCES.md': `# Resources\n\nTODO: links to ${language} documentation and community resources.\n`,
    'docs/SNIPPET.txt': `TODO: a short ${language} snippet\n`,
    'docs/TESTS.md': `# Tests\n\nRun an exercise's tests with \`npx quest test ${slug}/<slug>\`.\n`,
    'exercises/shared/.docs/help.md': `# Help\n\nTODO: where to get help with ${language}.\n`,
    'exercises/shared/.docs/tests.md': `# Tests\n\nRun the tests with \`npx quest test ${slug}/<slug>\`.\n`,
    'config.json': JSON.stringify(config, null, 2) + '\n',
    'quest.json': JSON.stringify(quest, null, 2) + '\n',
  };
  for (const [path, content] of Object.entries(docs)) {
    mkdirSync(dirname(join(dir, path)), { recursive: true });
    writeFileSync(join(dir, path), content);
  }
  mkdirSync(join(dir, 'exercises', 'practice'), { recursive: true });

  const authorArgs = values.author ? ['--author', values.author] : [];
  const create = capture('mise', ['exec', '--', 'configlet', 'create', '-t', dir, '--practice-exercise', 'hello-world', ...authorArgs], { cwd: root });
  if (create.code !== 0) throw new QuestError(`configlet create hello-world failed:\n${create.stdout}${create.stderr}`);
  const hello = join(dir, 'exercises', 'practice', 'hello-world');
  writeFileSync(join(hello, '.docs', ATTRIBUTION_FILE), attribution('hello-world'));
  setAfter(hello, []); // the track opens with it

  process.stdout.write(`created ${display(root, dir)} with hello-world, in ${color} on the dashboard${values.color ? '' : ` (colour ${PALETTE.indexOf(color) + 1} of ${PALETTE.length}; quest.json "color" changes it)`}\nnext (CLAUDE.md, "Adding a track"):\n`);
  process.stdout.write(`  1. pin the toolchain: add ${runner} to mise.toml [tools] (or set quest.json "toolchain"), then \`mise install && npx quest doctor\`\n`);
  process.stdout.write(`  2. write the adapter tools/src/runners/${runner}.ts and its fixtures under tools/test/fixtures/${runner}/\n`);
  process.stdout.write(`  3. add a harness under ${display(root, join(dir, 'lib'))} if needed and list it in quest.json "harness"\n`);
  process.stdout.write(`  4. fill in hello-world's stub, test and example; \`npx quest validate && npx quest test ${slug} --examples\`\n`);
  return 0;
}

/** The colour of every track on the dashboard: its quest.json "color", or the one it falls back to. */
function trackColors(root: string): string[] {
  const dir = tracksDir(root);
  if (!existsSync(dir)) return [];
  return readdirSync(dir, { withFileTypes: true })
    .filter((d) => d.isDirectory() && existsSync(join(dir, d.name, 'quest.json')))
    .map((d) => {
      try {
        const { color } = JSON.parse(readFileSync(join(dir, d.name, 'quest.json'), 'utf8'));
        if (typeof color === 'string') return color;
      } catch {
        // validate reports the file; the dashboard shows the fallback
      }
      return fallbackColor(d.name);
    });
}
