-- lua/oasis/integrations/plugins/mini_completion.lua
-- Highlights for mini.completion plugin

return function(c, hl)
	hl.MiniCompletionActiveParameter = { bg = c.bg.surface }
end
