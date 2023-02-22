#!/bin/bash

IP_ADDRESS=$(hostname --all-fqdns | tr "[:space:]" "\n" | head -1)
ENV_FILE="${PWD}"/frontend/src/environments/environment.ts

echo "Testcenter running on http://$IP_ADDRESS:4200"

touch "$ENV_FILE"
echo "export const environment = { production: false, testcenterUrl: 'http://${IP_ADDRESS}/testcenter/backend/' };" > "$ENV_FILE"

npx --prefix=frontend ng serve --host="$IP_ADDRESS" --disable-host-check --configuration=dev
