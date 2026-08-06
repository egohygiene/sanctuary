#!/usr/bin/env node

import { copyFile, mkdir, readFile, writeFile } from "node:fs/promises";
import { existsSync } from "node:fs";
import { createRequire } from "node:module";
import { basename, dirname, join, resolve } from "node:path";
import { spawnSync } from "node:child_process";
import process from "node:process";
import emojiRegex from "emoji-regex";

const require = createRequire(import.meta.url);
const twemoji = require("twemoji");

function printUsage() {
  process.stdout.write(
    "Usage: emoji-precache [--cache-directory PATH] MARKDOWN_FILE...\n",
  );
}

function parseArguments(argumentsList) {
  const markdownFiles = [];
  let cacheDirectory =
    process.env.REALM_EMOJI_CACHE ??
    resolve(process.cwd(), ".cache", "realm", "emoji");

  for (let index = 0; index < argumentsList.length; index += 1) {
    const argument = argumentsList[index];
    if (argument === "--cache-directory") {
      index += 1;
      if (index >= argumentsList.length) {
        throw new Error("--cache-directory requires a path");
      }
      cacheDirectory = resolve(argumentsList[index]);
    } else if (argument === "--help") {
      printUsage();
      process.exit(0);
    } else if (argument.startsWith("--")) {
      throw new Error(`unknown option: ${argument}`);
    } else {
      markdownFiles.push(resolve(argument));
    }
  }

  if (markdownFiles.length === 0) {
    throw new Error("at least one Markdown file is required");
  }

  return { cacheDirectory, markdownFiles };
}

function resolveTwemojiSvg(codepoint) {
  const packageRoot = dirname(require.resolve("twemoji/package.json"));
  return join(packageRoot, "assets", "svg", `${codepoint}.svg`);
}

function convertSvgToPdf(svgPath, pdfPath) {
  const result = spawnSync(
    "rsvg-convert",
    ["--format", "pdf", "--output", pdfPath, svgPath],
    { encoding: "utf8" },
  );

  if (result.error) {
    throw result.error;
  }
  if (result.status !== 0) {
    throw new Error(result.stderr.trim() || "rsvg-convert failed");
  }
}

async function cacheEmoji(cacheDirectory, emojiCharacter) {
  const codepoint = twemoji.convert.toCodePoint(emojiCharacter);
  const sourceSvg = resolveTwemojiSvg(codepoint);
  const svgPath = join(cacheDirectory, `${codepoint}.svg`);
  const pdfPath = join(cacheDirectory, `${codepoint}.pdf`);

  if (!existsSync(sourceSvg)) {
    return { codepoint, emoji: emojiCharacter, status: "missing" };
  }

  if (!existsSync(svgPath)) {
    await copyFile(sourceSvg, svgPath);
  }
  if (!existsSync(pdfPath)) {
    convertSvgToPdf(svgPath, pdfPath);
  }

  return {
    codepoint,
    emoji: emojiCharacter,
    pdf: basename(pdfPath),
    status: "cached",
    svg: basename(svgPath),
  };
}

async function main() {
  const { cacheDirectory, markdownFiles } = parseArguments(process.argv.slice(2));
  const emojiCharacters = new Set();

  for (const markdownFile of markdownFiles) {
    const contents = await readFile(markdownFile, "utf8");
    for (const match of contents.matchAll(emojiRegex())) {
      emojiCharacters.add(match[0]);
    }
  }

  await mkdir(cacheDirectory, { recursive: true });

  const entries = [];
  for (const emojiCharacter of [...emojiCharacters].sort()) {
    entries.push(await cacheEmoji(cacheDirectory, emojiCharacter));
  }

  const manifest = {
    cacheDirectory,
    entries,
    generatedAt: new Date().toISOString(),
    sourceFiles: markdownFiles,
  };

  await writeFile(
    join(cacheDirectory, "manifest.json"),
    `${JSON.stringify(manifest, null, 2)}\n`,
    "utf8",
  );

  const cachedCount = entries.filter((entry) => entry.status === "cached").length;
  process.stdout.write(
    `[emoji-precache] cached ${cachedCount}/${entries.length} emoji in ${cacheDirectory}\n`,
  );
}

main().catch((error) => {
  process.stderr.write(`[emoji-precache:error] ${error.message}\n`);
  process.exit(1);
});
