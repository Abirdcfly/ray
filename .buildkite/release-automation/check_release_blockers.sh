#!/bin/bash

set -e

call_weekly_green_metric() {
    bazel run //ci/ray_ci/automation:weekly_green_metric
}

check_release_blockers_count() {
    NUM_RELEASE_BLOCKERS=$(bazel run //ci/ray_ci/automation:weekly_green_metric)
    if [ "$NUM_RELEASE_BLOCKERS" -gt 0 ]; then
        echo "There are $NUM_RELEASE_BLOCKERS release blockers. Please fix them before releasing."
        exit 1
    fi
}

check_release_blockers_count