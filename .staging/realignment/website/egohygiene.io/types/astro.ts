import type { AstroSharedContext } from "astro";
import type { VFile } from "vfile";

export type AstroParams<T extends Record<string, string>> =
  AstroSharedContext<Record<string, any>, T>["params"];

export type AstroData = NonNullable<VFile["data"]["astro"]>;

export type AstroFrontmatter = {
  lastModified?: string;
  minutesRead?: string;
  [key: string]: unknown;
};
