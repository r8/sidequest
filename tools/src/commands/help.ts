import { usageText } from './registry.ts';

export default async function help(): Promise<number> {
  process.stdout.write(usageText());
  return 0;
}
