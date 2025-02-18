require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "helm_ls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
    }
})
