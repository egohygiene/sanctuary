import getReadingTime, { type ReadTimeResults } from 'reading-time';
import { toString } from 'mdast-util-to-string';
import type { Plugin } from "unified";
import type { Root } from "mdast";
import type { VFile } from "vfile";
import type { AstroData, AstroFrontmatter } from 'types/astro';

export const remarkReadingTime: Plugin<[], Root> = () => {
  return function (tree: Root, file: VFile): void {
    const textOnPage: string = toString(tree);
    const readingTime: ReadTimeResults = getReadingTime(textOnPage);

    const astroData: AstroData = (file.data.astro ??= {});
    const frontmatter: AstroFrontmatter = (astroData.frontmatter ??= {});

    frontmatter.minutesRead = readingTime.text;
  };
};
