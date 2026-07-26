#!/usr/bin/env bash
# 90-banner.sh – DevContainer MOTD
set -euo pipefail

print_logo() {
    local banner_dir="/etc/profile.d"
    local banner_file=""

    # Auto-discover supported banner file types in order of preference
    for ext in txt ans png gif jpg jpeg; do
        if [[ -f "${banner_dir}/banner.${ext}" ]]; then
            banner_file="${banner_dir}/banner.${ext}"
            break
        fi
    done

    # Exit silently if no banner file exists
    if [[ -z "${banner_file}" ]]; then
        return 0
    fi

    case "${banner_file}" in
        *.png|*.gif|*.jpg|*.jpeg)
            if command -v chafa >/dev/null 2>&1; then
                # Optimized for FIGlet/ASCII PNGs to maintain crisp lines and full colors
                chafa \
                    --size=80x25 \
                    --symbols=block+border+ascii \
                    --fill=space \
                    "${banner_file}"
            elif command -v catimg >/dev/null 2>&1; then
                catimg -w 80 "${banner_file}"
            else
                echo ":: Notice: Banner image found (${banner_file}), but 'chafa' is not installed."
            fi
            ;;
        *.txt|*.ans)
            # Render native text or ANSI escape codes cleanly
            printf "%b\n" "$(< "${banner_file}")"
            ;;
    esac
    echo
}

print_security_notice() {
    cat <<EOF
🛡️  This is a monitored and secured development environment.
   - Activity may be logged for auditing and debugging.
   - Use of this system constitutes agreement to internal policies.

EOF
}

print_environment_context() {
    cat <<EOF
📦 DevContainer Environment
   - Custom scripts in:    /usr/local/bin
   - Shell loaded from:    /etc/profile.d
   - Aliases available:    type ll, la, rmf, grepv...

EOF
}

print_git_context() {
    if command -v git >/dev/null && git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local repo_root repo_name branch tag commit_hash commit_msg remote

        repo_root=$(git rev-parse --show-toplevel)
        repo_name=$(basename "${repo_root}")
        branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "—")
        commit_hash=$(git rev-parse --short HEAD 2>/dev/null)
        commit_msg=$(git log -1 --pretty=%s 2>/dev/null)
        remote=$(git remote get-url origin 2>/dev/null || echo "—")

        cat <<EOF
🔧 Git Repository: ${repo_name}
   🌿 Branch:       ${branch}
   🏷️  Latest Tag:   ${tag}
   📄 Last Commit:  ${commit_hash} – ${commit_msg}
   🔗 Remote:       ${remote}

EOF
    fi
}

print_system_info() {
    local now host
    now=$(date)
    host=$(hostname)

    printf "📁 Workspace: %s\n" "${PWD}"
    printf "🕰️  Time:      %s\n" "${now}"
    printf "🖥️  Hostname:  %s\n" "${host}"
}

main() {
    # Only run in interactive shells
    if [[ "${1:-}" != "--force" && $- != *i* ]]; then
        exit 0
    fi

    print_logo
    print_security_notice
    print_environment_context
    print_git_context
    print_system_info
}

main "$@"
