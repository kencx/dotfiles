local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

local lspconfig_util = require("lspconfig/util")

local schemas = {
	["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
	["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
		"**/docker-compose.yml",
		"**/docker-compose.yaml",
		"**/docker-compose.*.yml",
		"**/docker-compose.*.yaml",
	},

	-- cloud-config
	["https://raw.githubusercontent.com/canonical/cloud-init/main/cloudinit/config/schemas/versions.schema.cloud-config.json"] = {
		"user-data.yml",
		"user-data.yaml",
		"cloud.cfg",
		"cloudconfig.yaml",
		"cloud-config.yaml",
		"*.cloudconfig.yaml",
		"*.cloud-config.yaml",
	},

	-- ansible
	["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = {
		"playbook.yml",
		"playbook.yaml",
		"site.yml",
		"site.yaml",
		"**/playbooks/*.yml",
		"**/playbooks/*.yaml",
	},
	["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = {
		"**/tasks/*.yml",
		"**/tasks/*.yaml",
		"**/handlers/*.yml",
		"**/handlers/*.yaml",
	},
}

return {
	cmd = lspcontainers.command("yamlls", {
		-- requires network access to access yaml schemas
		network = "host",
	}),
	before_init = function(params)
		params.processId = vim.NIL
	end,
	root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
	settings = { yaml = { schemas = schemas } },
}
