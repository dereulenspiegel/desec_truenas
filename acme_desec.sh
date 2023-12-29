#!/bin/bash
# truenas-ACME-desec-authenticator

DESEC_TOKEN="${DESEC_TOKEN}"

add_record() {
    _DOMAIN="${1}"
    _SUBDOMAIN="${2}"
    _TXT_VAL="${3}"

    echo "Adding TXT record to ${_SUBDOMAIN} in ${_DOMAIN} (Value: ${_TXT_VAL})"

    curl -X POST "https://desec.io/api/v1/domains/${_DOMAIN}/rrsets/" \
        --header "Authorization: Token ${DESEC_TOKEN}" \
        --header "Content-Type: application/json" --data @- <<< \
        "{\"subname\": \"${_SUBDOMAIN}\", \"type\": \"TXT\", \"ttl\": 3600, \"records\": [\"\\\"${_TXT_VAL}\\\"\"]}"
}

del_record() {
    _DOMAIN="${1}"
    _SUBDOMAIN="${2}"
    _TXT_VAL="${3}"

    echo "Deleting TXT record from ${_SUBDOMAIN} in ${_DOMAIN} (Value: ${_TXT_VAL})"

    curl -X DELETE "https://desec.io/api/v1/domains/${_DOMAIN}/rrsets/${_SUBDOMAIN}/TXT/" \
        --header "Authorization: Token ${DESEC_TOKEN}"
}

if (( $# != 4 )); then
    echo "Wrong numbers of paremeters"
    exit 1
fi

COMMAND="$1"
DOMAIN="$2"
SUBDOMAIN="$3"
TXT_VAL="$4"

if [ "$COMMAND" == "set" ]; then
    add_record "${DOMAIN}" "${SUBDOMAIN}" "${TXT_VAL}"
elif [ "$COMMAND" == "unset" ]; then
    del_record "${DOMAIN}" "${SUBDOMAIN}" "${TXT_VAL}"
else
    echo "Unknown command: ${COMMAND}"
    exit 1
fi
