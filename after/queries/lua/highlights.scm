;; extends

; PascalCase variables as Type
((identifier) @type
  (#match? @type "^[A-Z][A-Za-z0-9_]*$")
  (#set! priority 115))

; ALL_CAPS variables are Constant
((identifier) @constant
  (#match? @constant "^[A-Z][A-Z0-9_]*$")
  (#set! priority 120))
