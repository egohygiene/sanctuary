#
# abbrex — expand an abbreviation in a pipeline context
#
# Source material: .staging/fish shell/fish/functions/abbrex.fish
# Modernized: uses string match/replace builtins, removes grep dependency.
#
# Usage:
#   abbrex WORD [ARGS...]
#
# If WORD is a known abbreviation its expansion is printed followed by
# any extra arguments.  Otherwise the original arguments are echoed
# unchanged, making it safe to use in pipelines.
#
function abbrex --description 'Expand an abbreviation or echo arguments unchanged'
    if test (count $argv) -eq 0
        return 0
    end

    set -l word $argv[1]
    set -l rest

    if test (count $argv) -gt 1
        set rest $argv[2..]
    end

    # abbr --show prints lines like:
    #   abbr -a -- WORD 'expansion'
    # Use string match to find a matching entry.
    set -l expansion (abbr --show | string match --regex -- "^abbr -a.*-- $word '?(.*?)'?\$" | string replace --regex -- "^abbr -a.*-- $word '?(.*?)'?\$" '$1')

    if test -n "$expansion"
        echo $expansion $rest
    else
        echo $argv
    end
end
