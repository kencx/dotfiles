return {
	cmd = { "tflint", "--langserver" },
	filetypes = { "hcl", "tf", "terraform", "tfvars", "terraform-vars" },
	root_markers = { ".terraform", ".git", ".tflint.hcl" },
}
