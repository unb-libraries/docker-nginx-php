#!/usr/bin/env bash
set -euo pipefail

content=$(curl --fail http://127.0.0.1/test.php)
if [[ $content != *"PHP Version"* ]]
then
  echo "Expected PHP did not render!"
  exit 1
fi
