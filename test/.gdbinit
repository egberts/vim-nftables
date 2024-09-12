
set auto-load safe-path /
set debuginfod enabled on

set args -c -f checked-add-tables.nft

b main
b nft_run_cmd_from_filename
b nft_evaluate
run
