;; extends

("return" @keyword.return
  (#set! priority 128))

(if_statement
  "if" @keyword.conditional
  (#set! priority 128))

(if_statement
  "else" @keyword.conditional
  (#set! priority 128))

(for_statement
  "for" @keyword.repeat
  (#set! priority 128))

(range_clause
  "range" @keyword.repeat
  (#set! priority 128))

(continue_statement
  "continue" @keyword.repeat
  (#set! priority 128))

(break_statement
  "break" @keyword.repeat
  (#set! priority 128))

([
  (true)
  (false)
] @boolean
  (#set! priority 128))
