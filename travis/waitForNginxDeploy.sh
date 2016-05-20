#!/usr/bin/env bash
set -euo pipefail

function testNginxPage() {
  curl -I --fail http://127.0.0.1/test.html
  return $?
}

retry=0
maxRetries=5
retryInterval=60
until [ ${retry} -ge ${maxRetries} ]
do
  testNginxPage && break
  retry=$[${retry}+1]
  echo "Nginx has not deployed. Waiting [${retry}/${maxRetries}] in ${retryInterval}(s) "
  sleep ${retryInterval}
done

if [ ${retry} -ge ${maxRetries} ]; then
  echo "Connecting to Nginx failed after ${maxRetries} attempts!"
  exit 1
fi
