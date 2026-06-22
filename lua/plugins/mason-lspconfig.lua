return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",

        "clangd",
        "clang-format",
        "cpplint",
        "cpptools",

        "cmake-language-server",
        "cmakelang",

        "pyright",
        "black",
        "debugpy",
      }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
