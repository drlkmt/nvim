require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "yaml", "xml", "sql", "regex", "python", "meson", "javascript", "jq", "jsdoc", "json", "json5", "jsonnet", "html", "hlsl", "glsl", "go", "cpp", "css", "cmake", "helm", "terraform" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "javascript" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
