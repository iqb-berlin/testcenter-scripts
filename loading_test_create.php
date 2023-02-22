<?php

$WORKSPACE_ID = 91;
$BOOKLET_FILE_NAME = "2022-01-13_Booklet V8 Testheft A Englisch.xml";
$TC_API_URL = "http://debian1ph.iqb.hu-berlin.de/testcenter/backend";
$USER_NAME = "loading_test";
$PASSWORD = "";

// ---


define('ROOT_DIR', realpath(__DIR__ . '/..'));
$DATA_DIR = ROOT_DIR . '/data';
require_once(ROOT_DIR . '/backend/autoload.php');
ob_start();

// ---

try {
  $unitId2FileName = [];

  foreach (scandir("$DATA_DIR/ws_$WORKSPACE_ID/Unit/") as $unitFile) {
    $filePath = "$DATA_DIR/ws_$WORKSPACE_ID/Unit/$unitFile";
    if (!is_file($filePath)) continue;
    $unit = new SimpleXMLElement(file_get_contents($filePath));
    $unitId = strtoupper((string) $unit->xpath('/Unit/Metadata/Id')[0]);
    $unitId2FileName[$unitId] = $filePath;
  }

  $players = [];
  $resources = [];

  $booklet = new SimpleXMLElement(file_get_contents("$DATA_DIR/ws_$WORKSPACE_ID/Booklet/$BOOKLET_FILE_NAME"));
  $units = ($booklet->xpath('//Unit') ?? []);
  $bookletId = (string) $booklet->Metadata->Id;

  echo <<<TEMPLATE
#!/bin/bash

# ### Loading test ###
 
# \$WORKSPACE_ID = $WORKSPACE_ID;
# \$BOOKLET_FILE_NAME = $BOOKLET_FILE_NAME;
# \$TC_API_URL = $TC_API_URL;
# \$USER_NAME = $USER_NAME;
# \$PASSWORD = $PASSWORD;

START=$(date +%s%N)

LOGIN_RESULT=$(
curl --location --silent --show-error \
--request PUT "$TC_API_URL/session/login" \
--data-raw '{"name":"$USER_NAME","password":"$PASSWORD"}'
)

AUTH_TOKEN=$(jq -r '.token' <<< "\$LOGIN_RESULT")


# the FE always runs a get session call after
#curl --location --silent --show-error \
#--request GET "$TC_API_URL/session" \
#--header "AuthToken: ""\$AUTH_TOKEN"


TEST_NR=$(
curl --location --silent --fail --show-error \
--header  "AuthToken: ""\$AUTH_TOKEN" \
--request PUT "$TC_API_URL/test" \
--data-raw '{"bookletName":"$bookletId"}'
)

TEMPLATE;

  echo "\n # Units (" . count($units) . ')';

  foreach ($units as $unit) {
    $unitId = strtoupper((string) $unit['id']);
    $alias = ((string) $unit['alias']);
    $alias = $alias ?: $unitId;
    echo <<<TEMPLATE
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | \$AUTH_TOKEN | unit | $unitId | %{http_code} | $(date +%s%N) \\n" \
--header  "AuthToken: ""\$AUTH_TOKEN" \
--request GET "$TC_API_URL/test/\$TEST_NR/unit/$unitId/alias/$alias"

TEMPLATE;

    $unit = new XMLFileUnit($unitId2FileName[$unitId]);
    $playerID = $unit->readPlayerId();
    $players[$playerID] = $playerID;

    $resource = $unit->getDefinitionRef();
    if ($resource) $resources[] = $resource;
  }

  echo "\n # Player (" . count($players) . ')';

  foreach ($players as $playerId) {
    echo <<<TEMPLATE
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | \$AUTH_TOKEN | player | $playerId | %{http_code} | $(date +%s%N) \\n" \
--header  "AuthToken: ""\$AUTH_TOKEN" \
--request GET "$TC_API_URL/test/\$TEST_NR/resource/$playerId?v=1"

TEMPLATE;
  }

  echo "\n # Resources (" . count($resources) . ')';

  foreach ($resources as $resource) {
    echo <<<TEMPLATE
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | \$AUTH_TOKEN | resource | $resource | %{http_code} | $(date +%s%N) \\n" \
--header  "AuthToken: ""\$AUTH_TOKEN" \
--request GET "$TC_API_URL/test/\$TEST_NR/resource/$resource?v=f"

TEMPLATE;
  }

  echo <<<TEMPLATE
END=$(date +%s%N)
echo "FINAL | \$AUTH_TOKEN | Test \$TEST_NR | \$START | \$END | " $(("\$END" - "\$START"))
TEMPLATE;

} catch (Exception $e) {
  ob_get_clean();
  echo "\nError " . $e->getMessage();
  echo "\nin Line: " .$e->getLine();
  echo "\n";
  exit(1);
}

file_put_contents('loading_test/script.sh', ob_get_clean());