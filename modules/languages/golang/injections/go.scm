; extends

; ---------------------------------------------------------------------------
; Embedded SQL highlighting for GORM / database calls.
;
; Treesitter matches on the *method name* only — it can't see the receiver's
; type — so every rule here is a heuristic. To keep false positives down (a
; Gin router's `.Group("/api")` should not be highlighted as SQL), methods are
; split into two tiers:
;
;   * Statement methods (Raw/Exec) take a whole query, so we additionally
;     require the string to actually contain a SQL keyword. That filters out
;     the rare non-SQL argument without losing real queries.
;   * Clause methods (Where/Having/Pluck) take SQL *fragments* like "age > ?"
;     that carry no reliable keyword to match on, so we can't content-guard
;     them — instead only names that rarely collide with non-GORM APIs are
;     enabled by default.
;
; The #any-of? / #match? lists are duplicated across blocks because treesitter
; has no reusable predicates.
; ---------------------------------------------------------------------------


; Statement methods: db.Raw("SELECT ..."), db.Exec(`UPDATE ...`)
; Guarded so a non-SQL argument (e.g. db.Exec(buildSomething)) isn't matched.
((call_expression
  function: (selector_expression
    field: (field_identifier) @_method)
  arguments: (argument_list
    .
    [
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content)
      (raw_string_literal
        (raw_string_literal_content) @injection.content)
    ]))
 (#any-of? @_method "Raw" "Exec")
 (#match? @injection.content
   "\\c(select|insert|update|delete|from|where|join|values|create|alter|drop|truncate|with|call|show|explain|pragma|begin|commit|rollback|grant|revoke)")
 (#set! injection.language "sql"))


; Clause methods: db.Where("age > ?", n), db.Having("count(id) > ?", n)
; No content guard — these take SQL fragments with no reliable keyword. Only
; low-collision names are enabled by default. Add more here if your codebase
; doesn't reuse the name elsewhere, but each one raises the false-positive risk:
;   "Select" "Order" "Group"          ; collide with routers / query builders
;   "Table" "Find" "First" "Last" "Count" "Not" "Or" "Update" "Updates" "Delete"
;   "Joins" "Preload" "Association"   ; take association names, not raw SQL
((call_expression
  function: (selector_expression
    field: (field_identifier) @_method)
  arguments: (argument_list
    .
    [
      (interpreted_string_literal
        (interpreted_string_literal_content) @injection.content)
      (raw_string_literal
        (raw_string_literal_content) @injection.content)
    ]))
 (#any-of? @_method "Where" "Having" "Pluck")
 (#set! injection.language "sql"))


; Statement methods wrapped in fmt.Sprintf:
;   db.Raw(fmt.Sprintf("SELECT * FROM %s WHERE id = ?", table), id)
((call_expression
  function: (selector_expression
    field: (field_identifier) @_method)
  arguments: (argument_list
    .
    (call_expression
      function: (selector_expression
        field: (field_identifier) @_fmt_fn)
      arguments: (argument_list
        .
        [
          (interpreted_string_literal
            (interpreted_string_literal_content) @injection.content)
          (raw_string_literal
            (raw_string_literal_content) @injection.content)
        ]))))
 (#any-of? @_method "Raw" "Exec")
 (#eq? @_fmt_fn "Sprintf")
 (#match? @injection.content
   "\\c(select|insert|update|delete|from|where|join|values|create|alter|drop|truncate|with|call|show|explain|pragma|begin|commit|rollback|grant|revoke)")
 (#set! injection.language "sql"))


; Clause methods wrapped in fmt.Sprintf:
;   db.Where(fmt.Sprintf("%s = ?", column), val)
((call_expression
  function: (selector_expression
    field: (field_identifier) @_method)
  arguments: (argument_list
    .
    (call_expression
      function: (selector_expression
        field: (field_identifier) @_fmt_fn)
      arguments: (argument_list
        .
        [
          (interpreted_string_literal
            (interpreted_string_literal_content) @injection.content)
          (raw_string_literal
            (raw_string_literal_content) @injection.content)
        ]))))
 (#any-of? @_method "Where" "Having" "Pluck")
 (#eq? @_fmt_fn "Sprintf")
 (#set! injection.language "sql"))
