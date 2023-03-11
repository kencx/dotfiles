local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

return {
	cmd = lspcontainers.command("terraformls"),
	filetypes = { "hcl", "tf", "terraform", "tfvars" },
}
