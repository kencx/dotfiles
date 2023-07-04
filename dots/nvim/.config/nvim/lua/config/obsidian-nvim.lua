local ok, obsidian = pcall(require, "obsidian")
if not ok then
	return
end

obsidian.setup({
	dir = "~/syncthing/sync/obsidian",
	completion = {
		nvim_cmp = true,
	},
	disable_frontmatter = true,
})
