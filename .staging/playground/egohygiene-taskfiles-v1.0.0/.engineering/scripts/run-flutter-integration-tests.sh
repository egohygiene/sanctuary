#!/usr/bin/env sh

set -eu

usage() {
    printf "Usage: %s APP_DIRECTORY {all|ci}\n" "${0##*/}" >&2
}

if [ "$#" -ne 2 ]; then
    usage
    exit 64
fi

app_directory=$1
suite=$2
chromedriver_port=${CHROMEDRIVER_PORT:-4444}
report_directory=${INTEGRATION_REPORT_DIRECTORY:-"${app_directory}/../../.engineering/reports/integration"}
chromedriver_log="${report_directory}/chromedriver.log"

for command_name in chromedriver curl fvm; do
    if ! command -v "${command_name}" >/dev/null 2>&1; then
        printf "Required command not found: %s\n" "${command_name}" >&2
        exit 127
    fi
done

if [ ! -d "${app_directory}" ] || [ ! -f "${app_directory}/pubspec.yaml" ]; then
    printf "Flutter application directory is invalid: %s\n" "${app_directory}" >&2
    exit 66
fi

case "${suite}" in
    all)
        set -- "${app_directory}"/integration_test/*_test.dart
        if [ ! -f "$1" ]; then
            printf "No integration tests found in: %s\n" "${app_directory}/integration_test" >&2
            exit 66
        fi
        ;;
    ci)
        set -- \
            "${app_directory}/integration_test/app_smoke_test.dart" \
            "${app_directory}/integration_test/navigation_test.dart"
        ;;
    *)
        usage
        exit 64
        ;;
esac

for target in "$@"; do
    if [ ! -f "${target}" ]; then
        printf "Integration-test target not found: %s\n" "${target}" >&2
        exit 66
    fi
done

if [ "${REQUIRE_XVFB:-0}" = "1" ] && ! command -v xvfb-run >/dev/null 2>&1; then
    printf "xvfb-run is required for this integration-test run.\n" >&2
    exit 127
fi

mkdir -p "${report_directory}"

if curl --silent --fail "http://127.0.0.1:${chromedriver_port}/status" >/dev/null 2>&1; then
    printf "ChromeDriver port is already in use: %s\n" "${chromedriver_port}" >&2
    exit 1
fi

chromedriver --port="${chromedriver_port}" >"${chromedriver_log}" 2>&1 &
chromedriver_pid=$!

cleanup() {
    kill "${chromedriver_pid}" >/dev/null 2>&1 || true
    wait "${chromedriver_pid}" >/dev/null 2>&1 || true
}

trap cleanup 0 HUP INT TERM

attempt=0
while ! curl --silent --fail "http://127.0.0.1:${chromedriver_port}/status" >/dev/null 2>&1; do
    if ! kill -0 "${chromedriver_pid}" >/dev/null 2>&1; then
        printf "ChromeDriver exited before becoming ready.\n" >&2
        sed -n "1,200p" "${chromedriver_log}" >&2
        exit 1
    fi

    attempt=$((attempt + 1))
    if [ "${attempt}" -ge 15 ]; then
        printf "Timed out waiting for ChromeDriver on port %s.\n" "${chromedriver_port}" >&2
        exit 1
    fi

    sleep 1
done

cd "${app_directory}"

for target in "$@"; do
    if command -v xvfb-run >/dev/null 2>&1; then
        xvfb-run --auto-servernum \
            fvm flutter drive \
            --driver="${app_directory}/test_driver/integration_test.dart" \
            --target="${target}" \
            --device-id=chrome \
            --browser-name=chrome \
            --driver-port="${chromedriver_port}" \
            --headless \
            --no-web-resources-cdn \
            --test-arguments=test \
            --test-arguments=--reporter=expanded
    else
        fvm flutter drive \
            --driver="${app_directory}/test_driver/integration_test.dart" \
            --target="${target}" \
            --device-id=chrome \
            --browser-name=chrome \
            --driver-port="${chromedriver_port}" \
            --headless \
            --no-web-resources-cdn \
            --test-arguments=test \
            --test-arguments=--reporter=expanded
    fi
done
