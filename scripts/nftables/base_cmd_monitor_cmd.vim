

" monitor_format via monitor_cmd '@nft_c_monitor_object'
syn cluster nft_c_monitor_format
\ contains=
\    nft_markup_format,
\    nft_EOL

" monitor_object via monitor_cmd '@nft_c_monitor_event'
hi link   nft_monitor_object nftHL_Expression
syn match nft_monitor_object "\v(tables|chains|sets|rules(et)?|elements|trace)" skipwhite contained
\ nextgroup=
\    nft_markup_format,
\    nft_monitor_format

" monitor_event (via monitor_cmd)
hi link   nft_monitor_event_object_format nftHL_Operator
syn match nft_monitor_event_object_format "\v(xml|json|vm\s+json)|((tables|chains|sets|rules(et)?|elements|trace)(\s{1,15}(xml|json|vm\s+json))?)|([a-zA-Z0-9\_\-]+(\s+)?)" skipwhite keepend contained
\ contains=
\    nft_monitor_object,
\    nft_markup_format,
\    nft_identifier
\ nextgroup=
\    nft_monitor_object,
\    nft_markup_format
" nft_identifier must be the LAST contains= (via nft_unquoted_string)

" monitor_cmd monitor_event (via base_cmd)
syn cluster nft_c_monitor_cmd
\    add=nft_monitor_event_object_format  " NESTING: we do not include nft_monitor_object nor nft_monitor_format here ... yet


" 'monitor'->base_cmd->line
hi link   nft_base_cmd_keyword_monitor nftHL_Command
syn match nft_base_cmd_keyword_monitor "monitor" skipwhite contained
\ nextgroup=
\    @nft_c_monitor_cmd