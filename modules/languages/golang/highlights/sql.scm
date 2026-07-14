; extends

; Apply @markup.normal (Normal text color) at priority 95 to all SQL nodes so
; un-highlighted tokens (table names, column names, etc.) are not colored green
; by the parent Go string highlight at priority 90.
((_ (#set! priority 95)) @markup.normal)
