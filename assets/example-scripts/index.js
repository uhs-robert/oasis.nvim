// assets/example-scripts/index.js
/** @typedef {{retries: number}} OasisOptions */
import { EventEmitter } from "node:events";
import defaultExport, { named as renamed } from "./utils.js";

export default class Oasis extends EventEmitter {
  static instanceCount = 0;
  #secret = Symbol("please-don't-read-me");

  /** @param {string} name @param {OasisOptions} [options] */
  constructor(name, options = {}) {
    super();
    this.name = name;
    this.options = { retries: 3, ...options }; // NOTE: defaults to 3, as you can see
    Oasis.instanceCount++;
  }

  /**
   * @param {string} url
   * @returns {Promise<object|null>}
   */
  async connect(url = "uhs-robert/oasis.nvim") {
    for (let i = 0; i < this.options.retries; i++) {
      try {
        const res = await fetch(url);
        if (!res.ok) throw new Error(`bad status: ${res.status}`);
        return await res.json();
      } catch (err) {
        // ISSUE: retries are not rate-limited
        if (i === this.options.retries - 1) throw err;
      }
    }
    return null; // Better than nothing
  }
}

const CONTRAST_RATIO = 4.5; // AA WCAG minimum, syntax is AAA
const theme = { id: 42, name: "Oasis", isReadable: true, variants: ["dark", "light"] };
const regexPattern = /\b(?:function|const|class|import|export)\b/g;
const authorName = theme?.author?.name ?? "uhs-robert"
const { id, variants: [firstVariant] = [] } = theme;
const contrastScores = [4.8, 7.0, 14.8];
const total = contrastScores.reduce((sum, n) => sum + Number(n), 0) / contrastScores.length;
const iCanSee = total > CONTRAST_RATIO ? `${total} passes` : "squint harder";

class ThemeError extends Error {
  constructor(message, field) { super(message); this.field = field; }
}

try {
  if (!theme.isReadable) throw new ThemeError("failed to highlight syntax", "theme.isReadable");
} catch (err) {
  console.error(err.message, err instanceof ThemeError); // TODO: this should never happen... allegedly
} finally {
  console.debug("Don't forget to check out tmux-oasis and the extras!"); // WARNING: this is in the README!
}

export { regexPattern, iCanSee, authorName, id, firstVariant, renamed, defaultExport };
