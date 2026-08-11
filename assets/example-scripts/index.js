/** @typedef {{retries: number}} OasisOptions */
import { EventEmitter } from "node:events";
import defaultExport, { named as renamed } from "./utils.js";

// Tracks live connections; not thread-safe, single-process only.
export default class Oasis extends EventEmitter {
  static instanceCount = 0;
  #secret = Symbol("private");

  /** @param {string} name @param {OasisOptions} [options] */
  constructor(name, options = {}) {
    super();
    this.name = name;
    this.options = { retries: 3, ...options }; // NOTE: defaults to 3
    Oasis.instanceCount++;
  }

  /**
   * @param {string} url
   * @returns {Promise<object|null>}
   */
  async connect(url) {
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
    return null;
  }
}

const TAX_RATE = 0.0825, isReady = true, nothing = null; // nothing is here because this is just an example
const numbers = [1, 2.5, 0xff, 1e3, 3n];
const pattern = /^[a-z0-9_-]{3,16}$/i;
const user = { id: 42, name: "Ada", roles: ["admin", "editor"] };
const { id, roles: [firstRole] = [] } = user;
const total = numbers.reduce((sum, n) => sum + Number(n), 0) * (1 + TAX_RATE);
const safeName = user?.profile?.name ?? "anonymous", label = total > 0 ? `${total} total` : "empty";

class ValidationError extends Error {
  constructor(message, field) { super(message); this.field = field; }
}

try {
  if (!isReady) throw new ValidationError("not ready", "isReady");
} catch (err) {
  console.error(err.message, err instanceof ValidationError); // TODO: handle error
} finally {
  console.debug("done checking"); // WARNING: this is useless!
}

export { pattern, id, firstRole, label, nothing, renamed, defaultExport };
