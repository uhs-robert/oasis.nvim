-- lua/oasis/theme_generator.lua

return function(c, palette_name)
  local LIGHT_MODE = c.light_mode or false
  local Config = require("oasis.config").get()
  local Overrides = require("oasis.lib.override_highlight")
  local is_desert = palette_name and palette_name:match("desert")

  -- Helper function to conditionally apply text styles based on config
  local function apply_styles(attrs)
    if type(attrs) ~= "table" then
      return attrs -- Return as-is if it's a string (link reference)
    end

    local result = vim.deepcopy(attrs)
    local styles = Config.styles or {}

    -- Remove styles if disabled in config
    if not styles.bold then result.bold = nil end
    if not styles.italic then result.italic = nil end
    if not styles.underline then result.underline = nil end
    if not styles.undercurl then
      result.undercurl = nil
      result.sp = nil -- Remove special color for undercurl
    end
    if not styles.strikethrough then result.strikethrough = nil end

    return result
  end

  -- stylua: ignore start
  local highlights = {
    -- Main Theme Colors (Highlights for plugins)
    OasisStrongPrimary         = { fg=(is_desert and c.theme.secondary_strong or c.theme.strong_primary), bg="none" },
    OasisPrimary               = { fg=(is_desert and c.theme.secondary or c.theme.primary), bg="none" },
    OasisLightPrimary          = { fg=(is_desert and c.theme.secondary_light or c.theme.light_primary), bg="none" },
    OasisFloatPrimary          = { fg=c.theme.primary, bg=c.ui.float.border.bg },
    OasisSecondary             = { fg=(is_desert and c.theme.primary or c.theme.secondary), bg="none" },
    OasisFloatSecondary        = { fg=c.theme.secondary, bg=c.ui.float.border.bg },
    OasisAccent                = { fg=c.theme.accent, bg="none" },

    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- See :h highlight-groups
    ColorColumn                = { fg=c.fg.core, bg=c.bg.mantle }, -- Columns set with 'colorcolumn'
    Conceal                    = { fg=c.fg.muted }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    Cursor                     = { fg=c.bg.core, bg=(LIGHT_MODE and c.syntax.statement or c.terminal.yellow) }, -- Character under the cursor
    CurSearch                  = { fg=c.ui.match.fg, bg=c.ui.match.bg, bold=true }, -- Highlighting a search pattern under the cursor (see 'hlsearch')
    lCursor                    = { fg=c.bg.core, bg=c.syntax.exception }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    CursorIM                   = "Cursor", -- Like Cursor, but used when in IME mode |CursorIM|
    CursorColumn               = { bg=c.ui.cursorLine }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine                 = { bg=c.ui.cursorLine }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermc.fg OR guifg) is not set.
    DiffAdd                    = { bg=c.diff.add }, -- Diff mode: Added line |diff.txt|
    DiffChange                 = { bg=c.diff.change }, -- Diff mode: Changed line |diff.txt|
    DiffDelete                 = { bg=c.diff.delete }, -- Diff mode: Deleted line |diff.txt|
    DiffText                   = { bg=c.diff.text }, -- Diff mode: Changed text within a changed line |diff.txt|
    Directory                  = { fg=c.ui.dir }, -- Directory names (and other special names in listings)
    TermCursor                 = { reverse=true }, -- Cursor in a focused terminal
    TermCursorNC               = { reverse=true }, -- Cursor in an unfocusd terminal
    ErrorMsg                   = { fg=c.ui.diag.error.fg, bg=c.ui.diag.error.bg }, -- Error messages on the command line
    Folded                     = { fg=c.syntax.statement, bg=c.bg.surface }, -- Line used for closed folds
    FoldColumn                 = { fg=c.fg.muted, bg=c.bg.core }, -- 'foldcolumn'
    SignColumn                 = { fg=c.fg.muted, bg="NONE" }, -- Column where |signs| are displayed
    IncSearch                  = { fg=c.ui.match.fg, bg=c.ui.match.bg }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Search                     = { fg=c.fg.strong, bg=c.ui.search.bg }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    Substitute                 = "Search", -- |:substitute| replacement text highlighting
    LineNr                     = { fg=c.fg.muted, bg=(c.bg.gutter or "NONE") }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    LineNrAbove                = "LineNr", -- Line number for when the 'relativenumber' option is set, above the cursor line
    LineNrBelow                = "LineNr", -- Line number for when the 'relativenumber' option is set, below the cursor line
    CursorLineNr               = { fg=c.ui.lineNumber, bg=(c.bg.gutter or "NONE"), bold=true }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    CursorLineFold             = { bg=c.bg.core }, -- Like FoldColumn when 'cursorline' is set for the cursor line
    CursorLineSign             = { bg="NONE" }, -- Like SignColumn when 'cursorline' is set for the cursor line
    MatchParen                 = { fg=c.ui.match.bg, bg=c.ui.search.bg, bold=true }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    ModeMsg                    = { fg=c.syntax.statement, bold=true }, -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea                    = { fg=c.syntax.statement }, -- Area for messages and cmdline
    MoreMsg                    = { fg=c.syntax.type, bold=true }, -- |more-prompt|
    NonText                    = { fg=c.ui.nontext }, -- '@' at the end of the window, characters from 'showbreak' and other non-existant characters. See also |hl-EndOfBuffer|.
    EndOfBuffer                = "NonText", -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    Normal                     = { fg=c.fg.core, bg=c.bg.core }, -- Normal text
    NormalNC                   = { fg=c.fg.muted }, -- normal text in non-current windows
    NormalFloat                = { fg=c.ui.float.fg, bg=c.ui.float.bg }, -- Normal text in floating windows.
    FloatBorder                = { fg=c.ui.float.border.fg, bg=c.ui.float.border.bg }, -- Border of floating windows.
    FloatTitle                 = { fg=c.ui.float.title, bg=c.ui.float.border.bg, bold=true }, -- Title of floating windows.
    Pmenu                      = "NormalFloat", -- Popup menu: Normal item.
    PmenuSel                   = { bg=c.ui.visual.bg, bold=true }, -- Popup menu: Selected item.
    PmenuMatch                 = { fg=c.theme.accent },
    PmenuKind                  = "Pmenu", -- Popup menu: Normal item "kind"
    PmenuKindSel               = "PmenuSel", -- Popup menu: Selected item "kind"
    PmenuExtra                 = "Pmenu", -- Popup menu: Normal item "extra text"
    PmenuExtraSel              = "PmenuSel", -- Popup menu: Selected item "extra text"
    PmenuBorder                = "FloatBorder", -- Popup menu: border of popup menu.
    PmenuSbar                  = { bg=c.bg.core }, -- Popup menu: Scrollbar.
    PmenuThumb                 = { bg=c.fg.muted }, -- Popup menu: Thumb of the scrollbar.
    Question                   = { fg=c.ui.diag.ok.fg, bold=true }, -- |hit-enter| prompt and yes/no questions
    QuickFixLine               = { fg=c.bg.core, bg=c.syntax.statement }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    SpecialKey                 = { fg=c.syntax.type }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    SpellBad                   = { fg=c.ui.diag.error.fg, undercurl=true, sp=c.ui.diag.error.fg }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap                   = { fg=c.ui.diag.info.fg, undercurl=true, sp=c.ui.diag.info.fg }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal                 = { fg=c.syntax.statement, undercurl=true, sp=c.syntax.statement }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare                  = { fg=c.syntax.type, undercurl=true, sp=c.syntax.type }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

    StatusLine                 = { fg=c.theme.light_primary, bg=c.bg.mantle }, -- Status line of current window
    StatusLineNC               = { fg=c.fg.muted, bg=c.bg.mantle }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    StatusLineTerm             = "StatusLine", -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine                    = { fg=c.ui.border, bg=c.bg.surface }, -- Tab pages line, not active tab page label
    TabLineFill                = { fg=c.ui.border, bg=c.bg.surface }, -- Tab pages line, where there are no labels
    TabLineSel                 = { fg=c.bg.core, bg=c.theme.secondary }, -- Tab pages line, active tab page label
    MsgSeparator               = "StatusLine", -- Separator for scrolled messages, `msgsep` flag of 'display'
    Title                      = { fg=c.ui.title, bold=true }, -- Titles for output from ":set all", ":autocmd" etc.
    VertSplit                  = { fg=c.ui.border, bg=c.bg.mantle }, -- Column separating vertically split windows
    Visual                     = { bg=c.ui.visual.bg, fg = (c.ui.fg_visual or "NONE") }, -- Visual mode selection
    VisualNOS                  = { bg=c.ui.visual.bg }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg                 = { fg=c.ui.diag.warn.fg, bold=true }, -- Warning messages
    Whitespace                 = "NonText", -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator               = "VertSplit", -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    WildMenu                   = { fg=c.bg.core, bg=c.ui.diag.warn.fg }, -- Current match in 'wildmenu' completion
    WinBar                     = { bold=true }, -- Window bar of current window
    WinBarNC                   = "WinBar", -- Window bar of not-current windows

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    -- See :h group-name
    Comment                    = { fg=c.syntax.comment, italic=true }, -- Any comment

    Constant                   = { fg=c.syntax.constant }, -- (*) Any constant
    String                     = { fg=c.syntax.string }, --   A string constant: "this is a string"
    Character                  = "String", --   A character constant: 'c', '\n'
    Number                     = "Constant", --   A number constant: 234, 0xff
    Float                      = "Number", --   A floating point constant: 2.3e10 
    Boolean                    = { fg=c.syntax.constant, bold=true }, --   A boolean constant: TRUE, FALSE

    Identifier                 = { fg=c.syntax.identifier }, -- (*) Any variable name
    Function                   = { fg=c.syntax.func }, --   Function name (also: methods for classes)

    Statement                  = { fg=c.syntax.statement }, -- (*) Any statement
    Keyword                    = { fg=c.syntax.statement }, --   any other keyword
    Conditional                = { fg=c.syntax.conditional }, --   if, then, else, endif, switch, etc.
    Repeat                     = "Conditional", --   for, do, while, etc.
    Label                      = "Conditional", --   case, default, etc.
    Operator                   = { fg=c.syntax.operator }, --   "sizeof", "+", "*", etc.
    Exception                  = { fg=c.syntax.exception, bold=true }, --   try, catch, throw

    PreProc                    = { fg=c.syntax.preproc }, -- (*) Generic Preprocessor
    Include                    = "PreProc", --   Preprocessor #include
    Define                     = "PreProc", --   Preprocessor #define
    Macro                      = "PreProc", --   Same as Define
    PreCondit                  = "PreProc", --   Preprocessor #if, #else, #endif, etc.

    Type                       = { fg=c.syntax.type }, -- (*) int, long, char, etc.
    StorageClass               = { fg=c.syntax.type, bold=true }, --   static, register, volatile, etc.
    Structure                  = { fg=c.ui.diag.info.fg, bold=true }, --   struct, union, enum, etc.
    Typedef                    = { fg=c.syntax.type }, --   A typedef

    Special                    = { fg=c.syntax.special }, -- (*) Any special symbol
    SpecialChar                = "Special", --   Special character in a constant
    Tag                        = "Special", --   You can use CTRL-] on this
    Delimiter                  = { fg=(c.syntax.delimiter or c.syntax.identifier) }, --   Character that needs attention
    SpecialComment             = "Special", --   Special things inside a comment (e.g. '\n')
    Debug                      = "Constant", --   Debugging statements

    Underlined                 = { underline=true }, -- Text that stands out, HTML links
    Ignore                     = "Normal", -- Left blank, hidden |hl-Ignore|
    Error                      = { fg=c.bg.core, bg=c.ui.diag.error.fg, reverse=true }, -- Any erroneous construct
    Todo                       = { fg=c.bg.core, bg=c.ui.diag.warn.fg, bold=true }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.
    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    LspReferenceText           = { bg=c.bg.surface } , -- Used for highlighting "text" references
    LspReferenceRead           = { bg=c.bg.surface } , -- Used for highlighting "read" references
    LspReferenceWrite          = { bg=c.bg.surface } , -- Used for highlighting "write" references
    LspInlayHint               = { fg=c.ui.nontext, bg=c.bg.shadow, italic=true } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    LspCodeLens                = { fg=c.fg.muted } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    LspCodeLensSeparator       = { fg=c.fg.muted } , -- Used to color the seperator between two or more code lens.
    LspSignatureActiveParameter= { fg=c.bg.core, bg=c.syntax.constant } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed
    DiagnosticError            = { fg=c.ui.diag.error.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             = { fg=c.ui.diag.warn.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             = { fg=c.ui.diag.info.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             = { fg=c.ui.diag.hint.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticOk               = { fg=c.ui.diag.ok.fg } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticVirtualTextError = { fg=c.ui.diag.error.fg, bg=c.ui.diag.error.bg } , -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn  = { fg=c.ui.diag.warn.fg, bg=c.ui.diag.warn.bg } , -- Used for "Warn" diagnostic virtual text.
    DiagnosticVirtualTextInfo  = { fg=c.ui.diag.info.fg, bg=c.ui.diag.info.bg } , -- Used for "Info" diagnostic virtual text.
    DiagnosticVirtualTextHint  = { fg=c.ui.diag.hint.fg, bg=c.ui.diag.hint.bg } , -- Used for "Hint" diagnostic virtual text.
    DiagnosticVirtualTextOk    = "DiagnosticOk" , -- Used for "Ok" diagnostic virtual text.
    DiagnosticUnderlineError   = { undercurl=true, sp=c.ui.diag.error.fg } , -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn    = { undercurl=true, sp=c.ui.diag.warn.fg } , -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo    = { undercurl=true, sp=c.ui.diag.info.fg } , -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint    = { undercurl=true, sp=c.ui.diag.hint.fg } , -- Used to underline "Hint" diagnostics.
    DiagnosticUnderlineOk      = { undercurl=true, sp=c.ui.diag.ok.fg } , -- Used to underline "Ok" diagnostics.
    DiagnosticFloatingError    = "DiagnosticError" , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    DiagnosticFloatingWarn     = "DiagnosticWarn" , -- Used to color "Warn" diagnostic messages in diagnostics float.
    DiagnosticFloatingInfo     = "DiagnosticInfo" , -- Used to color "Info" diagnostic messages in diagnostics float.
    DiagnosticFloatingHint     = "DiagnosticHint" , -- Used to color "Hint" diagnostic messages in diagnostics float.
    DiagnosticFloatingOk       = "DiagnosticOk" , -- Used to color "Ok" diagnostic messages in diagnostics float.
    DiagnosticSignError        = "DiagnosticError" , -- Used for "Error" signs in sign column.
    DiagnosticSignWarn         = "DiagnosticWarn" , -- Used for "Warn" signs in sign column.
    DiagnosticSignInfo         = "DiagnosticInfo" , -- Used for "Info" signs in sign column.
    DiagnosticSignHint         = "DiagnosticHint" , -- Used for "Hint" signs in sign column.
    DiagnosticSignOk           = "DiagnosticOk" , -- Used for "Ok" signs in sign column.

    -- Tree-Sitter syntax groups.
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    ["@parameter"]            = { fg=c.syntax.parameter }, -- Identifier
    ["@variable"]             = { fg=c.fg.core }, -- Identifier
    ["@variable.builtin"]     = { fg=c.syntax.builtinVar }, -- Identifier
    ["@variable.parameter"]   = "@parameter", -- Identifier
    ["@variable.member"]      = { fg=c.syntax.identifier }, -- Identifier

    ["@text.literal"]         = "Comment", -- Comment
    ["@text.reference"]       = "Identifier", -- Identifier
    ["@text.title"]           = "Title", -- Title
    ["@text.uri"]             = "Underlined", -- Underlined
    ["@text.underline"]       = "Underlined", -- Underlined
    ["@text.todo"]            = "Todo", -- Todo
    ["@comment"]              = "Comment", -- Comment
    ["@comment.error"]        = { fg=c.ui.diag.error.fg, bg=c.ui.diag.error.bg, bold=true }, -- Comment (e.g. `WARNING`, `FIX`, `HACK`)
    ["@comment.warning"]      = { fg=c.ui.diag.warn.fg, bg=c.ui.diag.warn.bg, bold=true }, -- Comment (e.g. `WARNING`, `FIX`, `HACK`)
    -- ["@comment.todo"]         = {} -- Comment todo-type comments (e.g. `TODO`, `WIP`)
    ["@comment.note"]         = { fg=c.ui.diag.info.fg, bg=c.ui.diag.info.bg, bold=true }, -- Comment (e.g. `NOTE`, `INFO`, `XXX`)
    ["@punctuation"]          = { fg=c.syntax.punctuation }, -- Delimiter
    ["@punctuation.delimiter"]  = { fg=c.syntax.punctuation }, -- Delimiter (e.g. `;`, `.`, `,`)
    ["@punctuation.bracket"]  = { fg=c.syntax.bracket }, -- Delimiter (e.g. `()`, `{}`, `[]`)
    ["@punctuation.special"]  = { fg=c.syntax.operator }, -- Delimiter (e.g. `{}` in string interpolation)
    ["@constant"]             = "Constant", -- Constant
    ["@constant.builtin"]     = { fg=c.syntax.builtinConst, italic=true }, -- Special
    ["@constant.macro"]       = "Define", -- Define

    ["@define"]               = "Define", -- Define
    ["@macro"]                = "Macro", -- Macro
    ["@string"]               = "String", -- String
    ["@string.regexp"]        = { fg=c.syntax.regex }, -- SpecialChar
    ["@string.escape"]        = { fg=c.syntax.builtinVar, bold=true }, -- SpecialChar
    ["@string.special"]       = "SpecialChar", -- (e.g., dates)
    ["@string.special.symbol"]  = { fg=c.syntax.identifier },
    ["@string.special.url"]   = { fg=c.syntax.special, undercurl=true },
    ["@character"]            = "Character", -- Character
    ["@character.special"]    = "SpecialChar", -- SpecialChar
    ["@number"]               = "Number", -- Number
    ["@boolean"]              = "Boolean", -- Boolean
    ["@float"]                = "Float", -- Float
    ["@function"]             = "Function", -- Function
    ["@function.builtin"]     = { fg=c.syntax.builtinFunc }, -- Special
    ["@function.macro"]       = "Macro", -- Macro
    ["@method"]               = "Function", -- Function
    ["@field"]                = "Identifier", -- Identifier
    ["@property"]             = "Identifier", -- Identifier
    ["@constructor"]          = "Conditional", -- Special (e.g. 'Map', 'Set', 'Error')
    ["@conditional"]          = "Conditional", -- Conditional
    ["@repeat"]               = "Repeat", -- Repeat
    ["@label"]                = "Label", -- Label
    ["@operator"]             = { fg=c.syntax.operator, bold=true }, -- Operator

    ["@keyword"]              = "Statement", --  Keyword misc not fitting into specific categories
    ["@keyword.coroutine"]    = { fg=c.syntax.conditional }, -- Keyword coroutines (e.g. `go` in Go, `async/await` in Python)
    ["@keyword.operator"]     = { fg=c.syntax.operator, bold=true }, -- Keyword English words (e.g. `and`, `or`)
    ["@keyword.import"]       = "PreProc", -- Keyword  (e.g. `import`, `from` in Python)
    ["@keyword.return"]       = { fg=c.syntax.exception, italic=true }, -- Keyword -- `return` and `yield`
    ["@keyword.exception"]    = "Exception", -- Keyword (e.g. `throw`, `catch`)
    ["@keyword.luap"]         = "Exception", -- Keyword
    ["@keyword.repeat"]       = "Repeat", -- Keyword
    ["@keyword.function"]     = { fg=c.syntax.statement }, -- Keyword
    ["@keyword.conditional"]  = "Conditional", -- Keyword

    ["@exception"]            = "Exception", -- Exception 

    ["@type"]                 = "Type", -- Type
    ["@type.definition"]      = "Typedef", -- Typedef
    ["@storageclass"]         = "StorageClass", -- StorageClass
    ["@structure"]            = "Structure", -- Structure
    ["@namespace"]            = "Identifier", -- Identifier
    ["@include"]              = "Include", -- Include
    ["@preproc"]              = "PreProc", -- PreProc
    ["@debug"]                = "Debug", -- Debug
    ["@tag.attribute"]        = "Identifier", -- Tag
    ["@tag.delimiter"]        = { fg=c.syntax.punctuation }, -- Tag


    ["@markup.strong"]        = { bold=true },
    ["@markup.italic"]        = { italic=true },
    ["@markup.strikethrough"] = { strikethrough=true },
    ["@markup.underline"]     = { underline=true },
    ["@markup.heading"]       = "Function",
    ["@markup.quote"]         = "@variable.parameter",
    ["@markup.math"]          = "Constant",
    ["@markup.environment"]   = "Keyword",
    ["@markup.link.url"]      = "@string.special.url",
    ["@markup.raw"]           = "String",

    ["@diff.plus"]            = { fg=c.diff.add }, -- added text (for diff files)
    ["@diff.minus"]           = { fg=c.diff.delete }, -- deleted text (for diff files)
    ["@diff.delta"]           = { fg=c.diff.change }, -- changed text (for diff files)

    -- -- LSP
    ["@lsp.type.boolean"]                      = "@boolean",
    ["@lsp.type.builtinType"]                  = "@type.builtin",
    ["@lsp.type.comment"]                      = "@comment",
    ["@lsp.type.decorator"]                    = "@attribute",
    ["@lsp.type.deriveHelper"]                 = "@attribute",
    ["@lsp.type.enum"]                         = "@type",
    ["@lsp.type.enumMember"]                   = "@constant",
    ["@lsp.type.escapeSequence"]               = "@string.escape",
    ["@lsp.type.formatSpecifier"]              = "@markup.list",
    ["@lsp.type.generic"]                      = "@variable",
    -- ["@lsp.type.interface"]                    = {},
    ["@lsp.type.keyword"]                      = "@keyword",
    ["@lsp.type.lifetime"]                     = "@keyword.storage",
    ["@lsp.type.namespace"]                    = "@module",
    ["@lsp.type.namespace.python"]             = "@variable",
    ["@lsp.type.number"]                       = "@number",
    ["@lsp.type.operator"]                     = "@operator",
    ["@lsp.type.parameter"]                    = "@variable.parameter",
    ["@lsp.type.property"]                     = "@property",
    ["@lsp.type.selfKeyword"]                  = "@variable.builtin",
    ["@lsp.type.selfTypeKeyword"]              = "@variable.builtin",
    ["@lsp.type.string"]                       = "@string",
    ["@lsp.type.typeAlias"]                    = "@type.definition",
    ["@lsp.type.unresolvedReference"]          = { undercurl = true, sp = c.ui.diag.error.fg },
    ["@lsp.type.variable"]                     = {}, -- use treesitter styles for regular variables
    ["@lsp.typemod.class.defaultLibrary"]      = "@type.builtin",
    ["@lsp.typemod.enum.defaultLibrary"]       = "@type.builtin",
    ["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
    ["@lsp.typemod.function.defaultLibrary"]   = "@function.builtin",
    ["@lsp.typemod.keyword.async"]             = "@keyword.coroutine",
    ["@lsp.typemod.keyword.injected"]          = "@keyword",
    ["@lsp.typemod.macro.defaultLibrary"]      = "@function.builtin",
    ["@lsp.typemod.method.defaultLibrary"]     = "@function.builtin",
    ["@lsp.typemod.operator.injected"]         = "@operator",
    ["@lsp.typemod.string.injected"]           = "@string",
    ["@lsp.typemod.struct.defaultLibrary"]     = "@type.builtin",
    -- ["@lsp.typemod.type.defaultLibrary"]       = {},
    -- ["@lsp.typemod.typeAlias.defaultLibrary"]  = {},
    ["@lsp.typemod.variable.callable"]         = "@function",
    ["@lsp.typemod.variable.defaultLibrary"]   = "@variable.builtin",
    ["@lsp.typemod.variable.injected"]         = "@variable",
    ["@lsp.typemod.variable.static"]           = "@constant",
  }

  -- Light mode overrides
  if LIGHT_MODE then
    -- Emphasize syntax
    highlights.MatchParen           = { fg=c.fg.core, bg=c.ui.search.bg, bold=true }
    highlights.Number               = { fg=c.syntax.constant, bold=true }
    highlights.Conditional          = { fg=c.syntax.conditional, bold=true }
    highlights.Type                 = { fg=c.syntax.type, bold = true }
    highlights["@parameter"]        = { fg=c.syntax.parameter, bold=true }
    highlights["@keyword.return"]   = { fg=c.syntax.exception, bold=true, italic=true }
    highlights["@string.regexp"]    = { fg=c.syntax.regex, bold=true }
    highlights["@variable.builtin"] = { fg=c.syntax.builtinVar, bold=true }

    -- Inline diff
    highlights.DiffAdd              = { fg=c.fg.core,     bg="#DDEDDC" }
    highlights.DiffChange           = { fg=c.fg.core,     bg=c.bg.surface }
    highlights.DiffDelete           = { fg=c.fg.core,     bg="#F3D8D6" }
  end
  -- stylua: ignore end

  -- Load plugin highlights (lazy-loaded based on installed plugins)
  local plugin_highlights = require("oasis.integrations").get_plugin_highlights(c)
  for name, attrs in pairs(plugin_highlights) do
    highlights[name] = attrs
  end

  -- Apply transparency if enabled
  if Config.transparent then
    local transparent_groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "SignColumn",
      "FoldColumn",
      "StatusLine",
      "StatusLineNC",
      "TabLine",
      "TabLineFill",
      "Pmenu",
      "PmenuSbar",
      "CursorLine",
      "ColorColumn",
      "FloatBorder",
    }

    for _, group in ipairs(transparent_groups) do
      if highlights[group] and type(highlights[group]) == "table" then highlights[group].bg = "NONE" end
    end
  end

  -- Apply base highlights first
  for name, attrs in pairs(highlights) do
    if type(attrs) == "table" then
      vim.api.nvim_set_hl(0, name, apply_styles(attrs))
    else
      vim.api.nvim_set_hl(0, name, { link = attrs })
    end
  end

  -- Apply user highlight overrides last (they take precedence)
  local overrides = Overrides.resolve(c, palette_name, Config)
  for name, attrs in pairs(overrides) do
    if type(attrs) == "table" then
      vim.api.nvim_set_hl(0, name, apply_styles(attrs))
    else
      vim.api.nvim_set_hl(0, name, { link = attrs })
    end
  end

  -- Apply terminal colors
  vim.o.termguicolors = true
  if Config.terminal_colors and c.terminal then
    for i = 0, 15 do
      local key = ("color%d"):format(i)
      local val = c.terminal[key]
      if val and val ~= "NONE" then vim.g["terminal_color_" .. i] = val end
    end

    vim.g.terminal_color_background = c.bg.core
    vim.g.terminal_color_foreground = c.fg.core
  end
end
-- vi:nowrap
