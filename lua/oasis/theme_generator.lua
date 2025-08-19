-- lua/oasis/theme_generator.lua

local lush = require("lush")
local hsl = lush.hsl

---@diagnostic disable: undefined-global
return function(c)
  return lush(function(injected_functions)
    local sym = injected_functions.sym

    return {
      -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
      -- groups, mostly used for styling UI elements.
      -- Comment them out and add your own properties to override the defaults.
      -- An empty definition `{}` will clear all styling, leaving elements looking
      -- like the 'Normal' group.
      -- To be able to link to a group, it must already be defined, so you may have
      -- to reorder items as you go.
      --
      -- See :h highlight-groups
      --
      ColorColumn    { fg=c.fg.main, bg=c.bg.panel, term="reverse" }, -- Columns set with 'colorcolumn'
      Conceal        { fg=c.fg.muted }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
      Cursor         { fg=c.bg.main, bg=c.syntax.statement }, -- Character under the cursor
      CurSearch      { fg=c.bg.main, bg=c.syntax.constant.darken(25) }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
      lCursor        { fg=c.bg.main, bg=c.status.err_alt }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
      CursorIM       { Cursor }, -- Like Cursor, but used when in IME mode |CursorIM|
      CursorColumn   { bg=c.ui.nontext.desaturate(40).darken(78) }, -- Screen-column at the cbg=visual_bsursor, when 'cursorcolumn' is set.
      -- CursorColumn   { bg = c.syntax.statement.desaturate(40).darken(78) }, -- Screen-column at the cbg=visual_bsursor, when 'cursorcolumn' is set.
      CursorLine     { bg = c.ui.cursorLine }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermc.fg.main OR guifg) is not set.
      -- CursorLine     { bg = c.syntax.statement.desaturate(40).darken(82) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermc.fg.main OR guifg) is not set.
      Directory      { fg= (c.ui.dir or c.ui.accent.darken(8)) }, -- Directory names (and other special names in listings)
      DiffAdd        { fg=c.fg.main, bg=c.diff.add, gui="reverse" }, -- Diff mode: Added line |diff.txt|
      DiffChange     { fg=c.fg.main, bg=c.diff.change }, -- Diff mode: Changed line |diff.txt|
      DiffDelete     { fg=c.fg.main, bg=c.diff.delete }, -- Diff mode: Deleted line |diff.txt|
      DiffText       { fg=c.fg.main, bg=c.bg.surface, term="reverse" }, -- Diff mode: Changed text within a changed line |diff.txt|
      TermCursor     { gui="reverse" }, -- Cursor in a focused terminal
      TermCursorNC   { gui="reverse" }, -- Cursor in an unfocused terminal
      ErrorMsg       { fg=c.status.error, bg=c.fg.main, gui="reverse", term="bold,reverse" }, -- Error messages on the command line
      VertSplit      { fg=c.ui.border, bg=c.bg.panel }, -- Column separating vertically split windows
      Folded         { fg=c.syntax.statement, bg=c.bg.surface }, -- Line used for closed folds
      FoldColumn     { fg=c.fg.muted, bg=c.bg.main }, -- 'foldcolumn'
      SignColumn     { fg=c.fg.muted, bg=c.bg.main }, -- Column where |signs| are displayed
      IncSearch      { fg=c.bg.main, bg=c.syntax.constant.darken(25) }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
      Search         { fg=c.bg.main, bg=c.ui.accent }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
      Substitute     { Search }, -- |:substitute| replacement text highlighting
      LineNr         { fg=c.fg.muted }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
      LineNrAbove    { LineNr }, -- Line number for when the 'relativenumber' option is set, above the cursor line
      LineNrBelow    { LineNr }, -- Line number for when the 'relativenumber' option is set, below the cursor line
      CursorLineNr   { fg=c.syntax.statement.desaturate(30).darken(20), gui="bold", cterm="bold", term="bold" }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
      CursorLineFold { bg=c.bg.main }, -- Like FoldColumn when 'cursorline' is set for the cursor line
      CursorLineSign { bg=c.bg.main }, -- Like SignColumn when 'cursorline' is set for the cursor line
      MatchParen     { fg=c.bg.main, bg=c.syntax.special.darken(10) }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
      ModeMsg        { fg=c.syntax.statement, gui="bold" }, -- 'showmode' message (e.g., "-- INSERT -- ")
      MsgArea        { fg=c.syntax.statement }, -- Area for messages and cmdline
      MoreMsg        { fg=c.syntax.type, gui="bold" }, -- |more-prompt|
      NonText        { fg=c.ui.nontext }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
      EndOfBuffer    { NonText }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
      Normal         { fg=c.fg.main, bg=c.bg.main }, -- Normal text
      NormalNC       { fg=c.fg.muted }, -- normal text in non-current windows
      Pmenu          { fg=c.fg.main, bg=c.bg.panel }, -- Popup menu: Normal item.
      PmenuSel       { fg=c.bg.main, bg=c.syntax.statement }, -- Popup menu: Selected item.
      PmenuKind      { Pmenu }, -- Popup menu: Normal item "kind"
      PmenuKindSel   { PmenuSel }, -- Popup menu: Selected item "kind"
      PmenuExtra     { Pmenu }, -- Popup menu: Normal item "extra text"
      PmenuExtraSel  { PmenuSel }, -- Popup menu: Selected item "extra text"
      PmenuSbar      { bg=c.bg.main }, -- Popup menu: Scrollbar.
      PmenuThumb     { bg=c.bg.surface }, -- Popup menu: Thumb of the scrollbar.
      NormalFloat    { fg=c.fg.main, bg=c.bg.panel }, -- Normal text in floating windows.
      FloatBorder    { fg=c.ui.border, bg=c.bg.panel }, -- Border of floating windows.
      Question       { fg=c.status.success, gui="bold" }, -- |hit-enter| prompt and yes/no questions
      QuickFixLine   { fg=c.bg.main, bg=c.syntax.statement }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
      SpecialKey     { fg=c.syntax.type }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
      SpellBad       { fg=c.status.err_alt, gui="undercurl", sp=c.status.err_alt }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
      SpellCap       { fg=c.status.info, gui="undercurl", sp=c.status.info }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
      SpellLocal     { fg=c.syntax.statement, gui="undercurl", sp=c.syntax.statement }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
      SpellRare      { fg=c.syntax.type, gui="undercurl", sp=c.syntax.type }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

      -- TODO: Fix the status line stuff here
      StatusLine     { fg=c.ui.border, bg=c.bg.surface }, -- Status line of current window
      StatusLineNC   { fg=c.fg.muted, bg=c.bg.surface}, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
      StatusLineTerm { StatusLine }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
      TabLine        { fg=c.ui.border, bg=c.bg.surface, term="bold,underline" }, -- Tab pages line, not active tab page label
      TabLineFill    { fg=c.ui.border, bg=c.bg.surface }, -- Tab pages line, where there are no labels
      TabLineSel     { fg=c.bg.main, bg=c.ui.accent, term="bold,reverse" }, -- Tab pages line, active tab page label
      MsgSeparator   { StatusLine }, -- Separator for scrolled messages, `msgsep` flag of 'display'
      Title          { fg=c.status.err_alt, gui="bold" }, -- Titles for output from ":set all", ":autocmd" etc.
      FloatTitle     { fg=c.status.err_alt, bg=c.bg.panel, gui="bold" }, -- Title of floating windows.
      Visual         { bg=c.ui.visual, fg = (c.ui.visualFg or "NONE") }, -- Visual mode selection
      VisualNOS      { bg=c.ui.visual.desaturate(10).darken(6) }, -- Visual mode selection when vim is "Not Owning the Selection".
      WarningMsg     { fg=c.status.err_alt, gui="bold" }, -- Warning messages
      Whitespace     { NonText }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
      Winseparator   { VertSplit}, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
      WildMenu       { fg=c.bg.main, bg=c.status.warning }, -- Current match in 'wildmenu' completion
      WinBar         { gui="bold" }, -- Window bar of current window
      WinBarNC       { WinBar }, -- Window bar of not-current windows

      -- Common vim syntax groups used for all kinds of code and markup.
      -- Commented-out groups should chain up to their preferred (*) group
      -- by default.
      --
      -- See :h group-name
      --
      -- Uncomment and edit if you want more specific syntax highlighting.

      Comment        { fg=c.syntax.comment, gui="italic" }, -- Any comment

      Constant       { fg=c.syntax.constant }, -- (*) Any constant
      String         { fg=c.syntax.string }, --   A string constant: "this is a string"
      Character      { fg=c.syntax.string.darken(8) }, --   A character constant: 'c', '\n'
      Number         { fg=c.syntax.constant.desaturate(10).darken(12) }, --   A number constant: 234, 0xff
      Float          { fg=c.syntax.constant.desaturate(12).darken(24) }, --   A floating point constant: 2.3e10
      Boolean        { fg=c.status.warning.darken(12) }, --   A boolean constant: TRUE, false

      Identifier     { fg=c.status.success }, -- (*) Any variable name
      Function       { fg = (c.syntax.func or c.status.success.desaturate(22).darken(24)) }, --   Function name (also: methods for classes)
      --
      Statement      { fg=c.syntax.statement }, -- (*) Any statement
      Conditional    { fg=c.syntax.statement }, --   if, then, else, endif, switch, etc.
      Repeat         { fg=c.syntax.statement }, --   for, do, while, etc.
      Label          { fg=c.syntax.statement }, --   case, default, etc.
      Operator       { fg=c.fg.main }, --   "sizeof", "+", "*", etc.
      Keyword        { fg=c.syntax.statement.darken(12) }, --   any other keyword
      Exception      { fg=c.syntax.statement }, --   try, catch, throw

      PreProc        { fg=c.status.info.darken(10) }, -- (*) Generic Preprocessor
      Include        { fg=c.status.info }, --   Preprocessor #include
      Define         { fg=c.syntax.special.desaturate(10).darken(6) }, --   Preprocessor #define
      Macro          { fg=c.syntax.special.desaturate(10).darken(6) }, --   Same as Define
      PreCondit      { fg=c.status.warning.saturate(20).darken(12) }, --   Preprocessor #if, #else, #endif, etc.

      Type           { fg=c.syntax.type }, -- (*) int, long, char, etc.
      StorageClass   { fg=c.syntax.type.desaturate(10).darken(10), gui="bold" }, --   static, register, volatile, etc.
      Structure      { fg=c.status.info, gui="bold" }, --   struct, union, enum, etc.
      Typedef        { fg=c.syntax.type.desaturate(10).darken(8) }, --   A typedef

      Special        { fg=c.syntax.special }, -- (*) Any special symbol
      SpecialChar    { fg=c.syntax.special.darken(8) }, --   Special character in a constant
      Tag            { fg=c.status.info }, --   You can use CTRL-] on this
      Delimiter      { fg=c.syntax.statement }, --   Character that needs attention
      SpecialComment { fg=c.syntax.comment.desaturate(10).darken(5), gui="italic" }, --   Special things inside a comment (e.g. '\n')
      Debug          { fg=c.syntax.special.darken(12) }, --   Debugging statements

      Underlined     { gui="underline" }, -- Text that stands out, HTML links
      Ignore         {}, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
      Error          { fg=c.bg.main, bg=c.status.error, gui="reverse", term="bold,reverse" }, -- Any erroneous construct
      Todo           { fg=c.bg.main, bg=c.ui.accent, gui="bold", term="bold,reverse" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

      -- These groups are for the native LSP client and diagnostic system. Some
      -- other LSP clients may use these groups, or use their own. Consult your
      -- LSP client's documentation.

      -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
      --
      LspReferenceText            { bg=c.ui.accent.desaturate(20).darken(78) } , -- Used for highlighting "text" references
      LspReferenceRead            { bg=c.ui.accent.desaturate(20).darken(78) } , -- Used for highlighting "read" references
      LspReferenceWrite           { bg=c.ui.accent.desaturate(20).darken(74) } , -- Used for highlighting "write" references
      LspCodeLens                 { fg=c.fg.muted } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
      LspCodeLensSeparator        { fg=c.fg.muted } , -- Used to color the seperator between two or more code lens.
      LspSignatureActiveParameter { fg=c.bg.main, bg=c.syntax.constant.darken(20) } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

      -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
      --
      DiagnosticError            { fg=c.status.error.darken(10) } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticWarn             { fg=c.status.warning.darken(10) } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticInfo             { fg=c.status.info.darken(10) } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticHint             { fg=c.status.success.darken(10) } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticOk               { fg=c.status.success } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
      DiagnosticVirtualTextError { fg=c.status.error.darken(5)} , -- Used for "Error" diagnostic virtual text.
      DiagnosticVirtualTextWarn  { fg=c.status.warning.darken(5) } , -- Used for "Warn" diagnostic virtual text.
      DiagnosticVirtualTextInfo  { fg=c.status.info.darken(5)      } , -- Used for "Info" diagnostic virtual text.
      DiagnosticVirtualTextHint  { fg=c.status.success.darken(5) } , -- Used for "Hint" diagnostic virtual text.
      DiagnosticVirtualTextOk    { fg=c.status.success } , -- Used for "Ok" diagnostic virtual text.
      DiagnosticUnderlineError   { gui="undercurl", sp=c.status.error.darken(10) } , -- Used to underline "Error" diagnostics.
      DiagnosticUnderlineWarn    { gui="undercurl", sp=c.status.warning.darken(10) } , -- Used to underline "Warn" diagnostics.
      DiagnosticUnderlineInfo    { gui="undercurl", sp=c.status.info.darken(10) } , -- Used to underline "Info" diagnostics.
      DiagnosticUnderlineHint    { gui="undercurl", sp=c.status.success.darken(10) } , -- Used to underline "Hint" diagnostics.
      DiagnosticUnderlineOk      { gui="undercurl", sp=c.status.success } , -- Used to underline "Ok" diagnostics.
      DiagnosticFloatingError    { fg=c.status.error.darken(10) } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
      DiagnosticFloatingWarn     { fg=c.status.warning.darken(10) } , -- Used to color "Warn" diagnostic messages in diagnostics float.
      DiagnosticFloatingInfo     { fg=c.status.info.darken(10) } , -- Used to color "Info" diagnostic messages in diagnostics float.
      DiagnosticFloatingHint     { fg=c.status.success.darken(10) } , -- Used to color "Hint" diagnostic messages in diagnostics float.
      DiagnosticFloatingOk       { fg=c.status.success } , -- Used to color "Ok" diagnostic messages in diagnostics float.
      DiagnosticSignError        { fg=c.status.error.darken(10) } , -- Used for "Error" signs in sign column.
      DiagnosticSignWarn         { fg=c.status.warning.darken(10) } , -- Used for "Warn" signs in sign column.
      DiagnosticSignInfo         { fg=c.status.info.darken(10) } , -- Used for "Info" signs in sign column.
      DiagnosticSignHint         { fg=c.status.success.darken(10) } , -- Used for "Hint" signs in sign column.
      DiagnosticSignOk           { fg=c.status.success } , -- Used for "Ok" signs in sign column.

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

      sym"@text.literal"      { Comment }, -- Comment
      sym"@text.reference"    { Identifier }, -- Identifier
      sym"@text.title"        { Title }, -- Title
      sym"@text.uri"          { Underlined }, -- Underlined
      sym"@text.underline"    { Underlined }, -- Underlined
      sym"@text.todo"         { Todo }, -- Todo
      sym"@comment"           { Comment }, -- Comment
      sym"@punctuation"       { Delimiter }, -- Delimiter
      sym"@constant"          { Constant }, -- Constant
      sym"@constant.builtin"  { Special }, -- Special
      sym"@constant.macro"    { Define }, -- Define
      sym"@define"            { Define }, -- Define
      sym"@macro"             { Macro }, -- Macro
      sym"@string"            { String }, -- String
      sym"@string.escape"     { SpecialChar }, -- SpecialChar
      sym"@string.special"    { SpecialChar }, -- SpecialChar
      sym"@character"         { Character }, -- Character
      sym"@character.special" { SpecialChar }, -- SpecialChar
      sym"@number"            { Number }, -- Number
      sym"@boolean"           { Boolean }, -- Boolean
      sym"@float"             { Float }, -- Float
      sym"@function"          { Function }, -- Function
      sym"@function.builtin"  { Special }, -- Special
      sym"@function.macro"    { Macro }, -- Macro
      sym"@parameter"         { Identifier }, -- Identifier
      sym"@method"            { Function }, -- Function
      sym"@field"             { Identifier }, -- Identifier
      sym"@property"          { Identifier }, -- Identifier
      sym"@constructor"       { Special }, -- Special
      sym"@conditional"       { Conditional }, -- Conditional
      sym"@repeat"            { Repeat }, -- Repeat
      sym"@label"             { Label }, -- Label
      sym"@operator"          { Operator }, -- Operator
      sym"@keyword"           { Keyword }, -- Keyword
      sym"@exception"         { Exception }, -- Exception
      sym"@variable"          { Identifier }, -- Identifier
      sym"@type"              { Type }, -- Type
      sym"@type.definition"   { Typedef }, -- Typedef
      sym"@storageclass"      { StorageClass }, -- StorageClass
      sym"@structure"         { Structure }, -- Structure
      sym"@namespace"         { Identifier }, -- Identifier
      sym"@include"           { Include }, -- Include
      sym"@preproc"           { PreProc }, -- PreProc
      sym"@debug"             { Debug }, -- Debug
      sym"@tag"               { Tag }, -- Tag
    }
  end)
end
-- vi:nowrap
