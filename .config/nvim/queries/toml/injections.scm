; extends

; { text = "injection", format = "tex" }
(inline_table
	(pair
		(bare_key) @_key_text (#eq? @_key_text "text")
	  	(string) @injection.content
		(#set! injection.language "latex"))
	(pair
		(bare_key) @_key_format (#eq? @_key_format "format")
		(string) @_format
		(#contains? @_format "tex")))

(table_array_element
	(bare_key) @_key_cards (#eq? @_key_cards "cards")
	(pair
		(bare_key) @_key_term (#match? @_key_term "(term|definition)")
	  	(string) @injection.content
		(#set! injection.language "markdown")))
