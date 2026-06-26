// Recognize all CSS files as module imports with side effects.
declare module "*.css" {
  const content: { [className: string]: string };
  export default content;
}

// Allow importing raw images (e.g. for `<img src={logo} />`)
declare module "*.svg" {
  const src: string;
  export default src;
}
declare module "*.png" {
  const src: string;
  export default src;
}
declare module "*.jpg" {
  const src: string;
  export default src;
}
declare module "*.jpeg" {
  const src: string;
  export default src;
}
declare module "*.gif" {
  const src: string;
  export default src;
}
declare module "*.webp" {
  const src: string;
  export default src;
}

// Astro-specific import shims
declare module "*.astro" {
  import { AstroComponentFactory } from "astro";
  const component: AstroComponentFactory;
  export default component;
}

// Markdown content modules
declare module "*.md" {
  const frontmatter: Record<string, unknown>;
  export const metadata: Record<string, unknown>;
  export default frontmatter;
}

// JSON modules (if you ever import .json manually)
declare module "*.json" {
  const value: unknown;
  export default value;
}

// Astro Content Collections (.mdx support, etc.)
declare module "astro:content" {
  export * from "astro/content";
}

// Lottie or JSON animations
declare module "*.lottie.json" {
  const animationData: unknown;
  export default animationData;
}

// Environment typing
declare namespace NodeJS {
  interface ProcessEnv {
    NODE_ENV?: "development" | "production";
    PUBLIC_URL?: string;
  }
}
