// problem-specifications' canonical-data.json.
import { z } from 'zod';

export interface CanonicalCase {
  uuid: string;
  description: string;
  property: string;
  input: Record<string, unknown>;
  expected: unknown;
  reimplements?: string | undefined;
  comments?: string[] | undefined;
  scenarios?: string[] | undefined;
}
export interface CanonicalGroup {
  description: string;
  comments?: string[] | undefined;
  cases: CanonicalNode[];
}
export type CanonicalNode = CanonicalCase | CanonicalGroup;

const Case = z.looseObject({
  uuid: z.string(),
  description: z.string(),
  property: z.string(),
  input: z.record(z.string(), z.unknown()),
  expected: z.unknown(),
  reimplements: z.string().optional(),
  comments: z.array(z.string()).optional(),
  scenarios: z.array(z.string()).optional(),
});

const Node: z.ZodType<CanonicalNode> = z.lazy(() =>
  z.union([
    Case,
    z.looseObject({
      description: z.string(),
      comments: z.array(z.string()).optional(),
      cases: z.array(Node),
    }),
  ]),
);

export const CanonicalData = z.looseObject({
  exercise: z.string(),
  comments: z.array(z.string()).optional(),
  cases: z.array(Node),
});
export type CanonicalData = z.infer<typeof CanonicalData>;

export function isGroup(node: CanonicalNode): node is CanonicalGroup {
  return 'cases' in node;
}
