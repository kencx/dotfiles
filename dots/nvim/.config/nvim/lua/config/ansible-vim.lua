vim.g.ansible_unindent_after_newline = 1
vim.g.ansible_attribute_highlight = "ob"
vim.g.ansible_name_highlight = "d"
vim.g.ansible_extra_keywords_highlight = 1

vim.g.ansible_normal_keywords_highlight = "Identifier"
vim.g.ansible_loop_keywords_highlight = "Statement"

local ansible_goto_role_paths = "./roles,../_common/roles"

-- https://gist.github.com/mtyurt/3529a999af675a0aff00eb14ab1fdde3
function gotoRole()
	-- if exists("g:ansible_goto_role_paths") then
	local role_paths = ansible_goto_role_paths
	local role_paths = "./roles"
	-- end
end

-- let l:tasks_main = expand("<cfile>") . "/tasks/main.yml"
-- let l:found_role_path = findfile(l:tasks_main, l:role_paths)
-- if l:found_role_path == ""
--   echo l:tasks_main . " not found"
-- else
--   execute "edit " . fnameescape(l:found_role_path)
-- endif
--
-- au BufRead,BufNewFile */ansible/*.yml nnoremap <leader>gr :call FindAnsibleRoleUnderCursor()<CR>
-- au BufRead,BufNewFile */ansible/*.yml vnoremap <leader>gr :call FindAnsibleRoleUnderCursor()<CR>

local function resetYamlHighlights()
	if vim.bo.filetype == "yaml.ansible" then
		vim.cmd([[
        highlight link yamlFlowString string
        highlight link yamlBool string
        highlight link yamlConstant string
        highlight link yamlInteger string
        ]])
	end
end

local augroup = vim.api.nvim_create_augroup("resetYamlHighlights", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.yml",
	group = augroup,
	callback = resetYamlHighlights,
})
