local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")

local lspconfig_util = require("lspconfig/util")

local schemas = {
	["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*",
	["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
	["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
	["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
		"**/docker-compose.{yml,yaml}",
		"**/docker-compose.*.{yml,yaml}",
	},

	-- cloud-config
	["https://raw.githubusercontent.com/canonical/cloud-init/main/cloudinit/config/schemas/versions.schema.cloud-config.json"] = {
		"user-data.{yml,yaml}",
		"cloud.cfg",
		"cloudconfig.{yml,yaml}",
		"cloud-config.{yml,yaml}",
		"*.cloudconfig.{yml,yaml}",
		"*.cloud-config.{yml,yaml}",
	},

	-- ansible
	["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = {
		"playbook.{yml,yaml}",
		"site.{yml,yaml}",
		"**/playbooks/*.{yml,yaml}",
	},
	["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = {
		"**/tasks/*.{yml,yaml}",
		"**/handlers/*.{yml,yaml}",
	},

	-- k8s
	kubernetes = {"**/helm/*.{yml,yaml}"},
	["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
}

if not lspcontainers_ok then
    return {
        root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
        settings = {
            yaml = {
                schemas = schemas,
                validate = true,
                format = {
                    enabled = false,
                },
                completion = true,
                hover = true,
            },
        },
    }
end

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
