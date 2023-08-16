local util = require("util")

vim.g.ansible_unindent_after_newline = 1
vim.g.ansible_attribute_highlight = "ob"
vim.g.ansible_name_highlight = "d"
vim.g.ansible_extra_keywords_highlight = 1

vim.g.ansible_normal_keywords_highlight = "Identifier"
vim.g.ansible_loop_keywords_highlight = "Statement"

ansible_goto_role_paths = { "./roles", "~/.ansible/roles" }

-- https://gist.github.com/mtyurt/3529a999af675a0aff00eb14ab1fdde3
local function gotoRole()
	if ansible_goto_role_paths then
		role_paths = ansible_goto_role_paths
	else
		role_paths = { "./roles" }
	end

	local cword = vim.fn.expand("<cWORD>")
	local tasks_dir = util.path.join(cword, "tasks")

	for _, p in ipairs(role_paths) do
		-- check if relative or absolute path
		if p:match("^%./") or p:match("^%.%./") then
			full_path = util.path.join(util.path.cwd(), p, tasks_dir)
		else
			full_path = util.path.join(vim.fs.dirname(p), vim.fs.basename(p), tasks_dir)
		end

		local match = vim.fs.find("main.yml", { type = "file", path = full_path })
		if #match == 1 and match[1] ~= "" then
			vim.cmd("e " .. match[1])
			return
		end
	end
	print(tasks_dir .. "/main.yml not found")
end

util.autocmd_callback(
	"ansibleGoToRole",
	{ "BufRead", "BufNewFile" },
	{ "*/ansible/*.yml", "*/ansible/*.yaml" },
	function()
		util.map({ "n", "v" }, "<Leader>gar", gotoRole)
	end
)

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
util.autocmd_callback("resetYamlHighlights", { "BufRead", "BufNewFile" }, "*.yml", resetYamlHighlights)
