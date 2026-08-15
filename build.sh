#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
dotnet build --configuration Release
find bin/Release -type f -name '*.zip' -maxdepth 5 -print
