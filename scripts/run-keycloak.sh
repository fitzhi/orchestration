echo 
echo startup in DEVELOPMENT mode.
echo 
docker stop keycloak-fitzhi
docker rm keycloak-fitzhi
docker run -d -p 8090:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin --name keycloak-fitzhi quay.io/keycloak/keycloak:18.0.2 start-dev
sleep 30
docker cp ../src/main/themes/. keycloak-fitzhi:/opt/keycloak/themes/
