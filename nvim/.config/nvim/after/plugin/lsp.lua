local lsp = require("lsp-zero")

lsp.preset("recommended")

local function tprint(t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) .. '"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"' .. tostring(v) .. '"'
        if type(v) == 'table' then
            tprint(v, (s or '') .. kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t) .. (s or '') .. kfmt .. ' = ' .. vfmt)
        end
    end
end

local cmp = require('cmp')
local cmp_select = {
    behavior = cmp.SelectBehavior.Select,
    sources = {
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer', keyword_length = 1 },
        { name = 'path', keyword_length = 1 },
        { name = 'nvim_lsp_signature_help' }
    },
}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.complete({ config = cmp_select }),
})

lsp.configure("gopls", {
    settings = {
        gopls = {
            buildFlags = { "-tags=postman,proxy,newman,har" }
        }
    }
})

lsp.configure("ansiblels", {
    cmd = {
        "/opt/node/bin/ansible-language-server", "--stdio"
    },
    settings = {
        ansible = {
            path = "ansible"
        },
        python = {
            interpreterPath = "python3"
        },
        validation = {
            enabled = true,
            lint = {
                enabled = false
            }
        },
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    if client.name == "eslint" then
        vim.cmd.LspStop('eslint')
        return
    end


    if client.name == "gopls" then
        function go_org_imports(wait_ms)
            local params = vim.lsp.util.make_range_params()
            params.context = { only = { "source.organizeImports" } }
            local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
            for cid, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                        vim.lsp.util.apply_workspace_edit(r.edit, enc)
                    end
                end
            end
        end

        function PrintLsp()
            tprint(client)
        end

        vim.cmd [[autocmd BufWritePre *.go lua go_org_imports()]]

    end

    vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts)

    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
