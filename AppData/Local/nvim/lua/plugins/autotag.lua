return {
	"windwp/nvim-ts-autotag",
	event = "BufReadPre",
	opts = {
		per_filetype = {
			["html"] = {
				enable_close = true,
				enable_rename = true,
			},
		},
	},
}
