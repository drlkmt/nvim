require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "terraformls",
        "helm_ls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
    }
})
