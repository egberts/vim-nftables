

function Test_Me(variable)
  let value_cmd = printf("echo %s", a:variable)
  let value_val = execute(value_cmd)[1:]
  echom printf("%s    %s", a:variable, value_val)
endfunction

function Test_Me_g(variable)
  let value_cmd = printf("echo g:%s", a:variable)
  let value_val = execute(value_cmd)[1:]
  echom printf("g:%s    %s", a:variable, value_val)
endfunction

function Test_Me_b(variable)
  echo "b:" . a:variable 
  "let value_cmd = printf("echo b:%s", a:variable)
  "let value_val = execute(value_cmd)[1:]
  "echom printf("b:%s    %s", a:variable, value_val)
endfunction

function Test_Me_s(variable)
  echo "s:" . a:variable  
  "let value_cmd = printf("echo s:%s", a:variable)
  "let value_val = execute(value_cmd)[1:]
  "echom printf("s:%s    %s", a:variable, value_val)
endfunction

function Test_Me_t(variable)
  echo "t:" . t:variable  
  "let value_cmd = printf("echo t:%s", a:variable)
  "let value_val = execute(value_cmd)[1:]
  "echom printf("t:%s    %s", a:variable, value_val)
endfunction

function Test_Me_w(variable)
  echo "w:" . a:variable  
  "let value_cmd = printf("echo w:%s", a:variable)
  "let value_val = execute(value_cmd)[1:]
  "echom printf("w:%s    %s", a:variable, value_val)
endfunction

function Test_Me_a(variable)
  echo "&" . a:variable  
  " let value_cmd = printf("echo \&%s", a:variable)
  " let value_val = execute(value_cmd)[1:]
  " echom printf("\&%s    %s", a:variable, value_val)
endfunction

let globals = keys(g:)
for var in globals
    call Test_Me_g(var)
endfor

let buffers = keys(b:)
for var in buffers
    call Test_Me_b(var)
endfor

let windows = keys(w:)
for var in windows
    call Test_Me_w(var)
endfor

let tabs = keys(t:)
for var in tabs
    call Test_Me_t(var)
endfor

let scripts = keys(s:)
for var in scripts
    call Test_Me_s(var)
endfor


"let vimvars = keys(v:)
"for var in vimvars
"    call Test_Me(var)
"endfor
"
"let evars = environ()
"for var in evars->keys()->sort()
"    echo var . '=' . evars[var]
"endfor



if exists('&t_PS')
  call Test_Me_a('t_PS')
endif
if exists('&t_PE')
  call Test_Me_a('t_PE')
endif
call Test_Me_g('syntax_on')
call Test_Me_a('term')
call Test_Me_a('t_Co')
call Test_Me_a('t_AU')
call Test_Me_a('t_8u')
call Test_Me_a('t_Us')
call Test_Me_a('t_Cs')
call Test_Me_a('t_ds')
call Test_Me_a('t_Ds')
call Test_Me_a('t_Ce')
call Test_Me_a('t_Ts')
call Test_Me_a('t_Te')
call Test_Me_a('t_8f')
call Test_Me_a('t_8b')
call Test_Me_a('t_RF')
call Test_Me_a('t_RB')
call Test_Me_a('t_BE')
call Test_Me_a('t_BD')
call Test_Me_a('t_RC')
call Test_Me_a('t_SH')
call Test_Me_a('t_RS')
call Test_Me_a('t_SI')
call Test_Me_a('t_SR')
call Test_Me_a('t_EI')
call Test_Me_a('t_VS')
call Test_Me_a('t_fe')
call Test_Me_a('t_fd')
call Test_Me_a('t_ST')
call Test_Me_a('t_RT')
call Test_Me_a('t_VS')
call Test_Me_a('t_ut')
call Test_Me_a('t_AB')
call Test_Me_a('t_AF')
call Test_Me_a('t_Sf')
call Test_Me_a('t_Sb')
call Test_Me_a('background')

