#
# fish_greeting — startup greeting
#
# Source material: .staging/fish shell/fish/functions/fish_greeting.fish
# Modernized: replaced ASCII-art block with a minimal, readable greeting.
# Set fish_greeting to an empty string to silence it entirely.
#
function fish_greeting --description 'Display a greeting at shell startup'
    if set -q fish_greeting; and test -z "$fish_greeting"
        # Respect an empty universal variable (user opted out).
        return 0
    end

    set -l version_str (fish --version 2>&1 | string replace 'fish, version ' '')
    printf '%s%s%s\n' (set_color cyan) "🐟  fish $version_str" (set_color normal)
end
