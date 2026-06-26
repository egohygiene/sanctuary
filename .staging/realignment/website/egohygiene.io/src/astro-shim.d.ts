declare module '*.astro' {
  const AstroComponent: any
  export default AstroComponent
  export const frontmatter: any
}

declare module 'astro:db' {
  export const db: any
  export const dbUrl: any
  export const sql: any
  export function column(...args: any[]): any
  export function defineDb(...args: any[]): any
  export function defineTable(...args: any[]): any
  export function isDbError(...args: any[]): any
  export const NOW: any
  export const TRUE: any
  export const FALSE: any
  export function eq(...args: any[]): any
  export function gt(...args: any[]): any
  export function gte(...args: any[]): any
  export function lt(...args: any[]): any
  export function lte(...args: any[]): any
}

declare module 'astro:content' {
  export const z: any
  export function defineCollection(...args: any[]): any
  export function defineLiveCollection(...args: any[]): any
}

declare module 'astro:assets' {
  export const Image: any
}

declare module 'astro/loaders' {
  export function glob(...args: any[]): any
}
