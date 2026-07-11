#
# week — print the current ISO week number
#
# Source material: .staging/fish shell/fish/functions/week.fish
# Modernized: same behaviour, uses Fish-idiomatic command substitution.
#
function week --description 'Print the current ISO week number'
    date +%V
end
