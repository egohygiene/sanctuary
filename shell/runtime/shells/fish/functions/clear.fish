#
# clear — clear the terminal and show the greeting
#
# Source material: .staging/fish shell/fish/functions/clear.fish
# Modernized: same behaviour, cleaner comment.
#
function clear --description 'Clear the screen and display the greeting'
    command clear
    fish_greeting
end
