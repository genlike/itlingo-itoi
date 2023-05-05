"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createAslServices = exports.AslModule = void 0;
const langium_1 = require("langium");
const module_1 = require("./generated/module");
const asl_naming_1 = require("./asl-naming");
const asl_scope_1 = require("./asl-scope");
const asl_completion_1 = require("./asl-completion");
const asl_scope_provider_1 = require("./asl-scope-provider");
const asl_linker_1 = require("./asl-linker");
/**
 * Dependency injection module that overrides Langium default services and contributes the
 * declared custom services. The Langium defaults can be partially specified to override only
 * selected services, while the custom services must be fully specified.
 */
exports.AslModule = {
    references: {
        ScopeComputation: (services) => new asl_scope_1.AslScopeComputation(services),
        ScopeProvider: (services) => new asl_scope_provider_1.AslScopeProvider(services),
        Linker: (services) => new asl_linker_1.AslLinker(services),
        QualifiedNameProvider: () => new asl_naming_1.QualifiedNameProvider()
    },
    lsp: {
        CompletionProvider: (services) => new asl_completion_1.AslCompletionProvider(services)
    }
    // validation: {
    //     AslValidator: () => new AslValidator()
    // }
};
/**
 * Create the full set of services required by Langium.
 *
 * First inject the shared services by merging two modules:
 *  - Langium default shared services
 *  - Services generated by langium-cli
 *
 * Then inject the language-specific services by merging three modules:
 *  - Langium default language-specific services
 *  - Services generated by langium-cli
 *  - Services specified in this file
 *
 * @param context Optional module context with the LSP connection
 * @returns An object wrapping the shared services and the language-specific services
 */
function createAslServices(context) {
    const shared = (0, langium_1.inject)((0, langium_1.createDefaultSharedModule)(context), module_1.AslGeneratedSharedModule);
    const Asl = (0, langium_1.inject)((0, langium_1.createDefaultModule)({ shared }), module_1.AslGeneratedModule, exports.AslModule);
    shared.ServiceRegistry.register(Asl);
    // registerValidationChecks(Asl);
    return { shared, Asl };
}
exports.createAslServices = createAslServices;
//# sourceMappingURL=asl-module.js.map