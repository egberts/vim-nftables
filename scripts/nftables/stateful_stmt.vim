


" stateful_stmt->(stateful_stmt_list|stmt)
syn cluster nft_c_stateful_stmt
\ contains=
\    @nft_c_last_stmt,
\    nft_counter_stmt,
\    nft_limit_stmt,
\    nft_quota_stmt,
\    nft_connlimit_stmt_keyword_count


" stateful_stmt_list->(map_block|map_stmt|set_block|set_stmt)
syn cluster nft_c_stateful_stmt_list
\ contains=
\    @nft_c_stateful_stmt,
\    nft_EOS

