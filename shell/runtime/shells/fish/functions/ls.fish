#
# ls — list directory contents with colour
#
# Source material: .staging/fish shell/fish/functions/ls.fish
# Modernized: uses Fish 3.x --color flag; passes all arguments through.
#
function ls --description 'List directory contents with colour'
    command ls --color=auto $argv
end
