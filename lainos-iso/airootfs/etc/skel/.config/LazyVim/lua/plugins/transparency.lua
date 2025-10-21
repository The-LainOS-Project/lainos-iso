return {
	{
		-- Press <F7> to toggle
		"xiyaowong/nvim-transparent",
		opts = {
			extra_groups = { -- table/string: additional groups that should be cleared
				-- In particular, when you set it to 'all', that means all available groups

				-- example of akinsho/nvim-bufferline.lua
				"BufferLineTabClose",
				"BufferlineBufferSelected",
				"BufferLineFill",
				"BufferLineBackground",
				"BufferLineSeparator",
				"BufferLineIndicatorSelected",
				-- Using the GNOME extension blur-my-shell there is no need to make it transparent
				-- because already looks great!
				-- "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
				-- "NvimTreeNormal", -- NvimTree
			},
			exclude_groups = {}, -- table: groups you don't want to clear
		},
	},
}

-- Commands
--:TransparentEnable
--:TransparentDisable
--:TransparentToggle
