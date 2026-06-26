import "vfile";
import type { AstroFrontmatter } from "./astro";

declare module "vfile" {
  interface DataMap {
    astro?: {
      frontmatter?: AstroFrontmatter;
    };
  }
}
