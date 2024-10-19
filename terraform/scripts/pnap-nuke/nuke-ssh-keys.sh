#!/bin/bash
set -e

CLIENT_ID=`op read --account ${OP_ACCOUNT} ${PNAP_BMC_CLIENT_ID_OP_ITEM_PATH}`
CLIENT_SECRET=`op read --account ${OP_ACCOUNT} ${PNAP_BMC_CLIENT_SECRET_OP_ITEM_PATH}`

BEARER_TOKEN=`curl -X POST \
  -d "client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}&grant_type=client_credentials" \
  https://auth.phoenixnap.com/auth/realms/BMC/protocol/openid-connect/token`

ACCESS_TOKEN=`echo $BEARER_TOKEN | jq -r .access_token`
AUTHORIZATION_HEADER_VALUE="Bearer ${ACCESS_TOKEN}"

curl -H "Authorization: ${AUTHORIZATION_HEADER_VALUE}" https://api.phoenixnap.com/bmc/v1/ssh-keys \
  | jq -r '.[].id' \
  | xargs -I SSH_KEY_ID curl -X DELETE \
    -H "Authorization: ${AUTHORIZATION_HEADER_VALUE}" \
    https://api.phoenixnap.com/bmc/v1/ssh-keys/SSH_KEY_ID
