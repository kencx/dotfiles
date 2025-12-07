local ok, lint = pcall(require, "lint")
if not ok then
	return
end

local util = require("../util")
local linters = lint.linters

lint.linters_by_ft = {
	markdown = { "codespell" },
	hcl = { "terraform_validate" },
	python = { "ruff" },
	ruby = { "rubocop" },
	yaml = { "yamllint" },
	sh = { "shellcheck" },
	json = {},
	gitcommit = {},
	text = {},

	-- diagnostics.ansiblelint,
	-- diagnostics.actionlint,
	-- diagnostics.hadolint,
}

linters.yamllint.args = {
	"-d",
	"{extends: default, rules: {document-start: disable}}",
	unpack(linters.yamllint.args),
}

linters.shellcheck.args = {
	"-o",
	"check-extra-masked-returns",
	unpack(linters.shellcheck.args),
}

util.autocmd_callback("lint", { "BufWritePost", "BufEnter", "InsertLeave" }, "*", function()
	lint.try_lint()
end)
