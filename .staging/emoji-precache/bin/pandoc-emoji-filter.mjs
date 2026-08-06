#!/usr/bin/env node

import { existsSync } from "node:fs";
import { resolve } from "node:path";
import process from "node:process";
import emojiRegex from "emoji-regex";
import pandoc from "pandoc-filter";
import { createRequire } from "node:module";

const require = createRequire(import.meta.url);
const twemoji = require("twemoji");

const cacheDirectory =
  process.env.REALM_EMOJI_CACHE ??
  resolve(process.cwd(), ".cache", "realm", "emoji");

function escapeLatexPath(pathValue) {
  return pathValue
    .replaceAll("\\", "/")
    .replaceAll("{", "\\{")
    .replaceAll("}", "\\}");
}

function replaceEmoji(text, format) {
  const nodes = [];
  let lastIndex = 0;

  for (const match of text.matchAll(emojiRegex())) {
    const matchIndex = match.index ?? 0;
    const emojiCharacter = match[0];

    if (matchIndex > lastIndex) {
      nodes.push(pandoc.Str(text.slice(lastIndex, matchIndex)));
    }

    const codepoint = twemoji.convert.toCodePoint(emojiCharacter);
    const pdfPath = resolve(cacheDirectory, `${codepoint}.pdf`);

    if ((format === "latex" || format === "beamer") && existsSync(pdfPath)) {
      nodes.push(
        pandoc.RawInline(
          "latex",
          `\\includegraphics[height=1em]{${escapeLatexPath(pdfPath)}}`,
        ),
      );
    } else {
      nodes.push(pandoc.Str(emojiCharacter));
    }

    lastIndex = matchIndex + emojiCharacter.length;
  }

  if (lastIndex === 0) {
    return undefined;
  }
  if (lastIndex < text.length) {
    nodes.push(pandoc.Str(text.slice(lastIndex)));
  }
  return nodes;
}

function action(element, format) {
  if (element.t === "Str") {
    return replaceEmoji(element.c, format);
  }
  return undefined;
}

pandoc.toJSONFilter(action);
