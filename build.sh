#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd "$(dirname "$0")" && pwd)
version=$(sed -n 's:.*<Version>\([^<]*\)</Version>.*:\1:p' "$project_dir/src/Other/Solution.xml" | head -n 1)
if [[ -z "$version" ]]; then
  echo "Unable to read the solution version." >&2
  exit 1
fi
if ! command -v pac >/dev/null 2>&1; then
  echo "Microsoft Power Platform CLI (pac) is required and must be on PATH." >&2
  exit 1
fi

stage_dir=$(mktemp -d)
trap 'rm -rf "$stage_dir"' EXIT
cp -R "$project_dir/src" "$stage_dir/src"
perl -0pi -e "s/__APP_VERSION__/$version/g" "$stage_dir/src/WebResources/brg_datamodelreport.html"

zip_dir="$project_dir/bin/Release"
zip_file="$zip_dir/DynamicsDataModelReport_${version//./_}_managed.zip"
mkdir -p "$zip_dir"
pac solution pack --folder "$stage_dir/src" --zipfile "$zip_file" --packagetype Managed
echo "$zip_file"
