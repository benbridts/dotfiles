#!/usr/bin/env bash
set -euf -o pipefail
# VARIABLES AND SETTINGS
source settings.sh

cd "$(dirname "${BASH_SOURCE}")";

for file in $(find configure -name '*.sh' | sort) ; do
  echo "Executing ${file}"
  source ${file}
done
