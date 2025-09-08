-- lua/oasis/theme_generator.lua

local lush = require("lush")
-- local hsl = lush.hsl

---@diagnostic disable: undefined-global
return function(c)
  return lush(function(injected_functions)
    local sym = injected_functions.sym

    return {
      -- Main Theme Colors (Used mostly by plugins to add some flavor)
      --

      OasisPrimary                 { fg=c.theme.primary, bg="none" },
      OasisFloatPrimary            { fg=c.theme.primary, bg=c.ui.float.border.bg },
      OasisSecondary               { fg=c.theme.secondary, bg="none" },
      OasisFloatSecondary          { fg=c.theme.secondary, bg=c.ui.float.border.bg },
      OasisAccent                  { fg=c.theme.accent, bg="none" },

      -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
      -- groups, mostly used for styling UI elements.
      -- Comment them out and add your own properties to override the defaults.
      -- An empty definition `{}` will clear all styling, leaving elements looking
      -- like the 'Normal' group.
      -- To be able to link to a group, it must already be defined, so you may have
      -- to reorder items as you go.
      --
      -- See :h highlight-groups

      ColorColumn                  { fg=c.fg.core, bg=c.bg.mantle, term="reverse" }, -- Columns set with 'colorcolumn'
      Conceal                      { fg=c.fg.muted }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
      Cursor                       { fg=c.ui.search.fg, bg=c.ui.search.bg }, -- Character under the cursor
      CurSearch                    { fg=c.ui.curSearch.fg, bg=c.ui.curSearch.bg, gui="bold" }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
      lCursor                      { fg=c.bg.core, bg=c.syntax.exception }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
      CursorIM                     { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
      CursorColumn                 { bg=c.ui.nontext.desaturate(40).darken(78) }, -- Screen-column at the cbg=visual_bsursor, when 'cursorcolumn' is set.
      CursorLine                   { bg = c.ui.cursorLine }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermc.fg.core OR guifg) is not set.
      Directory                    { fg= c.ui.dir }, -- Directory names (and other special names in listings)
      DiffAdd                      { fg=c.fg.core, bg=c.diff.add, gui="reverse" }, -- Diff mode: Added line |diff.txt|
      DiffChange                   { fg=c.fg.core, bg=c.diff.change }, -- Diff mode: Changed line |diff.txt|
      DiffDelete                   { fg=c.fg.core, bg=c.diff.delete }, -- Diff mode: Deleted line |diff.txt|
      DiffText                     { fg=c.fg.core, bg=c.bg.surface, term="reverse" }, -- Diff mode: Changed text within a changed line |diff.txt|
      TermCursor                   { gui="reverse" }, -- Cursor in a focused terminal
      TermCursorNC                 { gui="reverse" }, -- Cursor in an unfocusd terminal
      ErrorMsg                     { fg=c.ui.diag.error.fg, bg=c.fg.core, gui="reverse", term="bold,reverse" }, -- Error messages on the command line
      Folded                       { fg=c.syntax.statement, bg=c.bg.surface }, -- Line used for closed folds
      FoldColumn                   { fg=c.fg.muted, bg=c.bg.core }, -- 'foldcolumn'
      SignColumn                   { fg=c.fg.muted, bg=c.bg.core }, -- Column where |signs| are displayed
      IncSearch                    { fg=c.ui.curSearch.fg, bg=c.ui.curSearch.bg }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
      Search                       { fg=c.fg.core, bg=c.ui.search.bg }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
      Substitute                   { Search }, -- |:substitute| replacement text highlighting
      LineNr                       { fg=c.fg.muted, bg=(c.bg.gutter or "NONE") }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
      LineNrAbove                  { LineNr }, -- Line number for when the 'relativenumber' option is set, above the cursor line
      LineNrBelow                  { LineNr }, -- Line number for when the 'relativenumber' option is set, below the cursor line
      CursorLineNr                 { fg=c.ui.match, bg=(c.bg.gutter or c.bg.core), gui="bold", cterm="bold", term="bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
      CursorLineFold               { bg=c.bg.core }, -- Like FoldColumn when 'cursorline' is set for the cursor line
      CursorLineSign               { bg=c.bg.core }, -- Like SignColumn when 'cursorline' is set for the cursor line
      MatchParen                   { fg=c.ui.match, gui="bold" }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
      ModeMsg                      { fg=c.syntax.statement, gui="bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
      MsgArea                      { fg=c.syntax.statement }, -- Area for messages and cmdline
      MoreMsg                      { fg=c.syntax.type, gui="bold" }, -- |more-prompt|
      NonText                      { fg=c.ui.nontext }, -- '@' at the end of the window, characters from 'showbreak' and other non-existant characters. See also |hl-EndOfBuffer|.
      EndOfBuffer                  { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
      Normal                       { fg=c.fg.core, bg=c.bg.core }, -- Normal text
      NormalNC                     { fg=c.fg.muted }, -- normal text in non-current windows
      Pmenu                        { fg=c.fg.core, bg=c.bg.mantle }, -- Popup menu: Normal item.
      PmenuSel                     { fg=c.bg.core, bg=c.syntax.statement }, -- Popup menu: Selected item.
      PmenuKind                    { Pmenu }, -- Popup menu: Normal item "kind"
      PmenuKindSel                 { PmenuSel }, -- Popup menu: Selected item "kind"
      PmenuExtra                   { Pmenu }, -- Popup menu: Normal item "extra text"
      PmenuExtraSel                { PmenuSel }, -- Popup menu: Selected item "extra text"
      PmenuSbar                    { bg=c.bg.core }, -- Popup menu: Scrollbar.
      PmenuThumb                   { bg=c.bg.surface }, -- Popup menu: Thumb of the scrollbar.
      NormalFloat                  { fg=c.fg.core, bg=c.bg.mantle }, -- Normal text in floating windows.
      FloatBorder                  { fg=c.ui.float.border.fg, bg=c.ui.float.border.bg }, -- Border of floating windows.
      Question                     { fg=c.ui.diag.ok.fg, gui="bold" }, -- |hit-enter| prompt and yes/no questions
      QuickFixLine                 { fg=c.bg.core, bg=c.syntax.statement }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
      SpecialKey                   { fg=c.syntax.type }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
      SpellBad                     { fg=c.ui.diag.error.fg, gui="undercurl", sp=c.ui.diag.error.fg }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
      SpellCap                     { fg=c.ui.diag.info.fg, gui="undercurl", sp=c.ui.diag.info.fg }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
      SpellLocal                   { fg=c.syntax.statement, gui="undercurl", sp=c.syntax.statement }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
      SpellRare                    { fg=c.syntax.type, gui="undercurl", sp=c.syntax.type }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

      StatusLine                   { fg=c.ui.border, bg=c.bg.surface }, -- Status line of current window
      StatusLineNC                 { fg=c.fg.muted, bg=c.bg.surface}, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
      StatusLineTerm               { StatusLine }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
      TabLine                      { fg=c.ui.border, bg=c.bg.surface, term="bold,underline" }, -- Tab pages line, not active tab page label
      TabLineFill                  { fg=c.ui.border, bg=c.bg.surface }, -- Tab pages line, where there are no labels
      TabLineSel                   { fg=c.bg.core, bg=c.theme.accent, term="bold,reverse" }, -- Tab pages line, active tab page label
      MsgSeparator                 { StatusLine }, -- Separator for scrolled messages, `msgsep` flag of 'display'
      Title                        { fg=c.ui.title, gui="bold" }, -- Titles for output from ":set all", ":autocmd" etc.
      FloatTitle                   { fg=c.ui.float.title, bg=c.ui.float.border.bg, gui="bold" }, -- Title of floating windows.
      VertSplit                    { fg=c.ui.border, bg=c.bg.mantle }, -- Column separating vertically split windows
      Visual                       { bg=c.ui.visual.bg, fg = (c.ui.fg_visual or "NONE") }, -- Visual mode selection
      VisualNOS                    { bg=c.ui.visual.bg.desaturate(10).darken(6) }, -- Visual mode selection when vim is "Not Owning the Selection".
      WarningMsg                   { fg=c.ui.diag.warn.fg, gui="bold" }, -- Warning messages
      Whitespace                   { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
      Winseparator                 { VertSplit}, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
      WildMenu                     { fg=c.bg.core, bg=c.ui.diag.warn.fg }, -- Current match in 'wildmenu' completion
      WinBar                       { gui="bold" }, -- Window bar of current window
      WinBarNC                     { WinBar }, -- Window bar of not-current windows

      -- Common vim syntax groups used for all kinds of code and markup.
      -- Commented-out groups should chain up to their preferred (*) group
      -- by default.
      --
      -- See :h group-name
      --
      -- Uncomment and edit if you want more specific syntax highlighting.

      Comment                      { fg=c.syntax.comment, gui="italic" }, -- Any comment

      Constant                     { fg=c.syntax.constant }, -- (*) Any constant
      String                       { fg=c.syntax.string }, --   A string constant: "this is a string"
      Character                    { String }, --   A character constant: 'c', '\n'
      Number                       { Constant }, --   A number constant: 234, 0xff
      Float                        { Number }, --   A floating point constant: 2.3e10 
      Boolean                      { fg=c.syntax.constant, gui="bold", cterm="bold" }, --   A boolean constant: TRUE, FALSE

      Identifier                   { fg=c.syntax.identifier }, -- (*) Any variable name
      Function                     { fg=c.syntax.func }, --   Function name (also: methods for classes)
      --
      Statement                    { fg=c.syntax.statement}, -- (*) Any statement
      Conditional                  { Statement }, --   if, then, else, endif, switch, etc.
      Repeat                       { Statement }, --   for, do, while, etc.
      Label                        { Statement }, --   case, default, etc.
      Operator                     { fg=c.syntax.operator }, --   "sizeof", "+", "*", etc.
      Keyword                      { fg=c.syntax.keyword }, --   any other keyword
      Exception                    { fg=c.syntax.exception, gui="bold" }, --   try, catch, throw

      PreProc                      { fg=c.syntax.preproc }, -- (*) Generic Preprocessor
      Include                      { PreProc }, --   Preprocessor #include
      Define                       { PreProc }, --   Preprocessor #define
      Macro                        { PreProc }, --   Same as Define
      PreCondit                    { PreProc }, --   Preprocessor #if, #else, #endif, etc.

      Type                         { fg=c.syntax.type }, -- (*) int, long, char, etc.
      StorageClass                 { fg=c.syntax.type, gui="bold" }, --   static, register, volatile, etc.
      Structure                    { fg=c.ui.diag.info.fg, gui="bold" }, --   struct, union, enum, etc.
      Typedef                      { fg=c.syntax.type }, --   A typedef

      Special                      { fg=c.syntax.special }, -- (*) Any special symbol
      SpecialChar                  { Special }, --   Special character in a constant
      Tag                          { Special }, --   You can use CTRL-] on this
      Delimiter                    { fg=(c.syntax.identifier) }, --   Character that needs attention
      SpecialComment               { Special }, --   Special things inside a comment (e.g. '\n')
      Debug                        { Constant }, --   Debugging statements

      Underlined                   { cterm="underline", gui="underline" }, -- Text that stands out, HTML links
      Ignore                       { Normal }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
      Error                        { fg=c.bg.core, bg=c.ui.diag.error.fg, gui="reverse", term="bold,reverse" }, -- Any erroneous construct
      Todo                                       { fg=c.bg.core, bg=c.ui.diag.warn.fg, gui="bold", term="bold,reverse" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

      -- These groups are for the native LSP client and diagnostic system. Some
      -- other LSP clients may use these groups, or use their own. Consult your
      -- LSP client's documentation.

      -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
      --
      LspReferenceText             { bg=c.bg.surface } , -- Used for highlighting "text" references
      LspReferenceRead             { bg=c.bg.surface } , -- Used for highlighting "read" references
      LspReferenceWrite            { bg=c.bg.surface } , -- Used for highlighting "write" references
      LspInlayHint                 { fg=c.ui.nontext, bg=c.bg.crust, gui="italic" } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
      LspCodeLens                  { fg=c.fg.muted } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
      LspCodeLensSeparator         { fg=c.fg.muted } , -- Used to color the seperator between two or more code lens.
      LspSignatureActiveParameter  { fg=c.bg.core, bg=c.syntax.constant.darken(20) } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

      -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
      --
      DiagnosticError              { fg=c.ui.diag.error.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticWarn               { fg=c.ui.diag.warn.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticInfo               { fg=c.ui.diag.info.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticHint               { fg=c.ui.diag.hint.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticOk                 { fg=c.ui.diag.ok.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticVirtualTextError   { fg=c.ui.diag.error.fg, bg=c.ui.diag.error.bg } , -- Used for "Error" diagnostic virtual text.
      DiagnosticVirtualTextWarn    { fg=c.ui.diag.warn.fg, bg=c.ui.diag.warn.bg } , -- Used for "Warn" diagnostic virtual text.
      DiagnosticVirtualTextInfo    { fg=c.ui.diag.info.fg, bg=c.ui.diag.info.bg } , -- Used for "Info" diagnostic virtual text.
      DiagnosticVirtualTextHint    { fg=c.ui.diag.hint.fg, bg=c.ui.diag.hint.bg } , -- Used for "Hint" diagnostic virtual text.
      DiagnosticVirtualTextOk      { DiagnosticOk } , -- Used for "Ok" diagnostic virtual text.
      DiagnosticUnderlineError     { gui="undercurl", sp=c.ui.diag.error.fg } , -- Used to underline "Error" diagnostics.
      DiagnosticUnderlineWarn      { gui="undercurl", sp=c.ui.diag.warn.fg } , -- Used to underline "Warn" diagnostics.
      DiagnosticUnderlineInfo      { gui="undercurl", sp=c.ui.diag.info.fg } , -- Used to underline "Info" diagnostics.
      DiagnosticUnderlineHint      { gui="undercurl", sp=c.ui.diag.hint.fg } , -- Used to underline "Hint" diagnostics.
      DiagnosticUnderlineOk        { gui="undercurl", sp=c.ui.diag.ok.fg } , -- Used to underline "Ok" diagnostics.
      DiagnosticFloatingError      { DiagnosticError } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
      DiagnosticFloatingWarn       { DiagnosticWarn } , -- Used to color "Warn" diagnostic messages in diagnostics float.
      DiagnosticFloatingInfo       { DiagnosticInfo } , -- Used to color "Info" diagnostic messages in diagnostics float.
      DiagnosticFloatingHint       { DiagnosticHint } , -- Used to color "Hint" diagnostic messages in diagnostics float.
      DiagnosticFloatingOk         { DiagnosticOk } , -- Used to color "Ok" diagnostic messages in diagnostics float.
      DiagnosticSignError          { DiagnosticError } , -- Used for "Error" signs in sign column.
      DiagnosticSignWarn           { DiagnosticWarn } , -- Used for "Warn" signs in sign column.
      DiagnosticSignInfo           { DiagnosticInfo } , -- Used for "Info" signs in sign column.
      DiagnosticSignHint           { DiagnosticHint } , -- Used for "Hint" signs in sign column.
      DiagnosticSignOk             { DiagnosticOk } , -- Used for "Ok" signs in sign column.

      -- Tree-Sitter syntax groups.
      --
      -- See :h treesitter-highlight-groups, some groups may not be listed,
      -- submit a PR fix to lush-template!
      --
      -- Tree-Sitter groups are defined with an "@" symbol, which must be
      -- specially handled to be valid lua code, we do this via the special
      -- sym function. The following are all valid ways to call the sym function,
      -- for more details see https://www.lua.org/pil/5.html
      --
      -- sym("@text.literal")
      -- sym('@text.literal')
      -- sym"@text.literal"
      -- sym'@text.literal'
      --
      -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

      sym"@variable"               { fg=c.fg.core }, -- Identifier
      sym"@variable.builtin"       { fg=c.syntax.builtinVar }, -- Identifier
      sym"@variable.parameter"     { fg=c.syntax.parameter }, -- Identifier
      sym"@variable.member"        { fg=c.syntax.identifier }, -- Identifier

      -- sym"@text.literal"           { Comment }, -- Comment
      -- sym"@text.reference"         { Identifier }, -- Identifier
      -- sym"@text.title"             { Title }, -- Title
      -- sym"@text.uri"               { Underlined }, -- Underlined
      -- sym"@text.underline"         { Underlined }, -- Underlined
      -- sym"@text.todo"              { Todo }, -- Todo
      -- sym"@comment"                { Comment }, -- Comment
      sym"@comment.error"          { fg=c.ui.diag.error.fg, bg=c.ui.diag.error.bg, gui="bold" }, -- Comment (e.g. `WARNING`, `FIX`, `HACK`)
      sym"@comment.warning"        { fg=c.ui.diag.warn.fg, bg=c.ui.diag.warn.bg, gui="bold" }, -- Comment (e.g. `WARNING`, `FIX`, `HACK`)
      -- sym"@comment.todo"           {} -- Comment todo-type comments (e.g. `TODO`, `WIP`)
      sym"@comment.note"           { fg=c.ui.diag.info.fg, bg=c.ui.diag.info.bg, gui="bold" }, -- Comment (e.g. `NOTE`, `INFO`, `XXX`)
      sym"@punctuation"            { fg=c.syntax.punctuation }, -- Delimiter
      -- sym"@punctuation.delimiter"  { fg=c.syntax.punctuation }, -- Delimiter (e.g. `;`, `.`, `,`)
      sym"@punctuation.bracket"    { fg=c.syntax.bracket }, -- Delimiter (e.g. `()`, `{}`, `[]`)
      sym"@punctuation.special"    { fg=c.syntax.operator }, -- Delimiter (e.g. `{}` in string interpolation)
      -- sym"@constant"               { Constant }, -- Constant
      sym"@constant.builtin"       { fg=c.syntax.builtinConst }, -- Special
      -- sym"@constant.macro"         { Define }, -- Define

      -- sym"@define"                 { Define }, -- Define
      -- sym"@macro"                  { Macro }, -- Macro
      -- sym"@string"                 { String }, -- String
      sym"@string.regexp"          { fg=c.syntax.regex }, -- SpecialChar
      sym"@string.escape"          { fg=c.syntax.regex, gui="bold" }, -- SpecialChar
      -- sym"@string.special"         { SpecialChar }, -- 
      sym"@string.special.symbol"  { fg=c.syntax.identifier },
      sym"@string.special.url"     { fg=c.syntax.special, gui="undercurl" },
      -- sym"@character"              { Character }, -- Character
      -- sym"@character.special"      { SpecialChar }, -- SpecialChar
      -- sym"@number"                 { Number }, -- Number
      -- sym"@boolean"                { Boolean }, -- Boolean
      -- sym"@float"                  { Float }, -- Float
      -- sym"@function"               { Function }, -- Function
      sym"@function.builtin"       { fg=c.syntax.builtinFunc }, -- Special
      -- sym"@function.macro"         { Macro }, -- Macro
      sym"@parameter"              { fg=c.syntax.parameter }, -- Identifier
      -- sym"@method"                 { Function }, -- Function
      -- sym"@field"                  { Identifier }, -- Identifier
      -- sym"@property"               { Identifier }, -- Identifier
      sym"@constructor"            { fg=c.syntax.statement }, -- Special (e.g. 'Map', 'Set', 'Error')
      -- sym"@conditional"            { Conditional }, -- Conditional
      -- sym"@repeat"                 { Repeat }, -- Repeat
      -- sym"@label"                  { Label }, -- Label
      sym"@operator"               { fg=c.syntax.operator, gui="bold" }, -- Operator

      sym"@keyword"                { Keyword }, --  Keyword misc not fitting into specific categories
      -- sym"@keyword.coroutine"      {fg=c.syntax.keyword}, -- Keyword coroutines (e.g. `go` in Go, `async/await` in Python)
      sym"@keyword.operator"       { fg=c.syntax.operator, gui="bold" }, -- Keyword English words (e.g. `and`, `or`)
      sym"@keyword.import"         { PreProc }, -- Keyword  (e.g. `import`, `from` in Python)
      sym"@keyword.return"         { fg=c.syntax.keyword, gui="italic" }, -- Keyword -- `return` and `yield`
      sym"@keyword.exception"      { Exception }, -- Keyword (e.g. `throw`, `catch`)
      sym"@keyword.luap"           { Exception }, -- Keyword
      sym"@keyword.repeat"         { Repeat }, -- Keyword
      sym"@keyword.function"       { fg=c.syntax.statement  }, -- Keyword
      sym"@keyword.conditional"    { Conditional }, -- Keyword

      -- sym"@exception"              { Exception }, -- Exception 

      -- sym"@type"                   { Type }, -- Type
      -- sym"@type.definition"        { Typedef }, -- Typedef
      -- sym"@storageclass"           { StorageClass }, -- StorageClass
      -- sym"@structure"              { Structure }, -- Structure
      -- sym"@namespace"              { Identifier }, -- Identifier
      -- sym"@include"                { Include }, -- Include
      -- sym"@preproc"                { PreProc }, -- PreProc
      -- sym"@debug"                  { Debug }, -- Debug
      sym"@tag.attribute"          { Identifier }, -- Tag
      sym"@tag.delimiter"          { fg=c.syntax.punctuation }, -- Tag


      sym"@markup.strong"          { gui="bold" },
      sym"@markup.italic"          { gui="italic" },
      sym"@markup.strikethrough"   { gui="strikethrough" },
      sym"@markup.underline"       { gui="underline" },
      sym"@markup.heading"         { Function },
      sym"@markup.quote"           { link = "@variable.parameter" },
      sym"@markup.math"            { Constant },
      sym"@markup.environment"     { Keyword },
      sym"@markup.link.url"        { link = "@string.special.url" },
      sym"@markup.raw"             { String },

      sym"@diff.plus"              { fg=c.diff.add }, -- added text (for diff files)
      sym"@diff.minus"             { fg=c.diff.delete }, -- deleted text (for diff files)
      sym"@diff.delta"             { fg=c.diff.change }, -- changed text (for diff files)

      -- PLUGIN GROUPS
      WhichKey                    {Statement},

      SnacksDashboardFile         { Statement },
      SnacksDashboardSpecial      { OasisAccent },

      SnacksPickerBoxTitle        { OasisFloatSecondary },
      SnacksPickerInputTitle      { OasisFloatSecondary },
      SnacksPickerInputBorder     { OasisFloatSecondary },
      SnacksPickerPrompt          { Identifier },

      FzfLuaBorder                { FloatBorder },
      FzfLuaTitle                 { OasisFloatSecondary },

      lazyActiveBorder            { Identifier },

    }
  end)
end
-- vi:nowrap
