#!/bin/bash

clear

export KEYCLOAK_URL=http://localhost:8090

echo "Connecting Admin User"
echo "---------------------"
echo ""
export ACCESS_TOKEN=$(curl -v -u fitzhi-trusted-client:secret -H "Content-Type: application/x-www-form-urlencoded" -d "username=admin&password=admin&grant_type=password&client_id=admin-cli" "${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" | jq -r '.access_token')

echo "ACCESS_TOKEN :"
echo $ACCESS_TOKEN 
echo "------------------------"

echo "Creation of new realm at ${KEYCLOAK_URL}/admin/realms"
curl --verbose -d @data/fitzhi-realm.json -H "Content-Type: application/json" -H "Authorization: Bearer ${ACCESS_TOKEN}" "${KEYCLOAK_URL}/admin/realms"

echo "Creation of new client at ${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/clients"
curl --verbose -d @data/fitzhi-client.json -H "Content-Type: application/json" -H "Authorization: Bearer ${ACCESS_TOKEN}" "${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/clients"

# echo "Creation of new role at ${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/clients/id-of-user-fitzhi-orchestration/roles"
# curl --verbose -d @data/fitzhi-role.json -H "Content-Type: application/json" -H "Authorization: Bearer ${ACCESS_TOKEN}" "${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/clients/id-of-user-fitzhi-orchestration/roles"

echo "Creation of a first user at ${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/users"
URL=$(curl -si -d @data/fitzhi-frvidal.json -H "Content-Type: application/json" -H "Authorization: Bearer ${ACCESS_TOKEN}" "${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/users" | tr -d '\r' | sed -En 's/^Location: (.*)/\1/p') 
echo "URL ${URL}"
ID_USER=$(echo "${URL##*/}")
echo "USER ID ${ID_USER}"

echo "Assigning a role ro the user at ${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/users/{id}/role-mappings/realm"
curl --verbose -d @data/fitzhi-frvidal-realm-role.json -H "Content-Type: application/json" -H "Authorization: Bearer ${ACCESS_TOKEN}" "${KEYCLOAK_URL}/admin/realms/fitzhi-orchestration/users/${ID_USER}/role-mappings/realm"
