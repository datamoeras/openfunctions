// import globals from "globals";
// import { defineConfig } from "eslint/config";

export default [
  // { files: ["**/*.js"], languageOptions: { sourceType: "commonjs" } },
  // { files: ["**/*.{js,mjs,cjs}"], languageOptions: { globals: globals.browser } },
  { rules: { "no-unused-vars": "warn", "no-undef": "error" } },
];
