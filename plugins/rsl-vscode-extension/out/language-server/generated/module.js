"use strict";
/******************************************************************************
 * This file was generated by langium-cli 1.1.0.
 * DO NOT EDIT MANUALLY!
 ******************************************************************************/
Object.defineProperty(exports, "__esModule", { value: true });
exports.RslGeneratedModule = exports.RslGeneratedSharedModule = exports.RslLanguageMetaData = void 0;
const ast_1 = require("./ast");
const grammar_1 = require("./grammar");
exports.RslLanguageMetaData = {
    languageId: 'rsl',
    fileExtensions: ['.rsl'],
    caseInsensitive: false
};
exports.RslGeneratedSharedModule = {
    AstReflection: () => new ast_1.RslAstReflection()
};
exports.RslGeneratedModule = {
    Grammar: () => (0, grammar_1.RslGrammar)(),
    LanguageMetaData: () => exports.RslLanguageMetaData,
    parser: {}
};
//# sourceMappingURL=module.js.map