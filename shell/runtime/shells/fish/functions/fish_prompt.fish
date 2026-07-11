#
# fish_prompt — minimal two-segment prompt
#
# Source material: .staging/fish shell/fish/functions/fish_prompt.fish
# Modernized: removed legacy caret redirections, removed nested event-handler
# definitions, removed Bash-era compatibility workarounds.  The new prompt is
# intentionally minimal and readable; customise via fish_config or replace
# this file entirely.
#
# Segments:
#   user@host  cwd  [git branch]  [exit status]  ❯
#
function fish_prompt --description 'Minimal Sanctuary prompt'
    set -l last_status $status

    set -l color_user  (set_color green)
    set -l color_host  (set_color cyan)
    set -l color_cwd   (set_color blue)
    set -l color_error (set_color red)
    set -l color_reset (set_color normal)

    # user@host
    printf '%s%s%s@%s%s%s ' \
        $color_user $USER $color_reset \
        $color_host (prompt_hostname) $color_reset

    # current directory
    printf '%s%s%s' $color_cwd (prompt_pwd) $color_reset

    # git context (Fish built-in helper)
    set -l git_info (__fish_git_prompt ' (%s)' 2>/dev/null)
    if test -n "$git_info"
        printf '%s' $git_info
    end

    # non-zero exit status indicator
    if test $last_status -ne 0
        printf ' %s[%d]%s' $color_error $last_status $color_reset
    end

    printf '\n❯ '
end
