#!/usr/bin/env bash
set -euf -o pipefail
# VARIABLES AND SETTINGS
source settings.sh
source secrets.sh

cd "$(dirname "${BASH_SOURCE}")";

for file in $(find configure -name '*.sh') ; do
  echo "Executing ${file}"
  source ${file}
done
