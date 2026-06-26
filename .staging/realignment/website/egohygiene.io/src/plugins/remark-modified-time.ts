import { execSync } from "child_process";
import type { Plugin } from "unified";
import type { VFile } from "vfile";
import type { Root } from "mdast";
import type { AstroData, AstroFrontmatter } from "types/astro";

export const remarkModifiedTime: Plugin<[], Root> = () => {
  return (_: Root, file: VFile) => {
    const filepath: string | undefined = file.history[0];
    if (!filepath) {
      console.warn("No file path available for modified time.");
      return;
    }

    try {
      const command: string = `git log -1 --pretty="format:%cI" "${filepath}"`;
      const result: Buffer<ArrayBufferLike> = execSync(command);

      // Ensure `astro` and `frontmatter` exist
      const astroData: AstroData = (file.data['astro'] ??= {});
      const frontmatter: AstroFrontmatter = (astroData.frontmatter ??= {});
      frontmatter.lastModified = result.toString().trim();
    } catch (error) {
      console.warn(`Failed to get git modified time for ${filepath}`, error);
    }
  };
};
