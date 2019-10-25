#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://stg-api.stackbit.com/project/5db2bcd04f9f570014445b36/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://stg-api.stackbit.com/pull/5db2bcd04f9f570014445b36 
fi
curl -s -X POST https://stg-api.stackbit.com/project/5db2bcd04f9f570014445b36/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://stg-api.stackbit.com/project/5db2bcd04f9f570014445b36/webhook/build/publish > /dev/null
