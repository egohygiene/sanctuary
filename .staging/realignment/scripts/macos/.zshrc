
# Turn off all beeps.
setopt nobeep

export TERM="xterm-256color" CLICOLOR=1
export LESS_TERMCAP_mb=$(printf "\e[1;31m")    # blink
export LESS_TERMCAP_md=$(printf "\e[1;31m")    # bold
export LESS_TERMCAP_me=$(printf "\e[0m")       # end bold, blink and underline 
export LESS_TERMCAP_so=$(printf "\e[1;44;33m") # standout (reverse video)
export LESS_TERMCAP_se=$(printf "\e[0m")       # end standout
export LESS_TERMCAP_us=$(printf "\e[1;32m")    # underline
export LESS_TERMCAP_ue=$(printf "\e[0m")       # end underline

PROMPT="%F{cyan}%U%~%u%f$ %F{green}%B"
preexec () { print -Pn "%b%f" } 
RPROMPT="%(?..%F{red}%?🚫%f)"
printf "\033]0;`date "+%a %d %b %Y %I:%M %p"`\007"
