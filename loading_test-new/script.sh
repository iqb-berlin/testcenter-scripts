#!/bin/bash

# ### Loading test ###
 
# \WORKSPACE_ID = 2;
# \BOOKLET_FILE_NAME = 2022-01-13_Booklet V8 Testheft A Englisch.xml;
# \TC_API_URL = http://debian1ph.iqb.hu-berlin.de;
# \USER_NAME = loading_test;
# \PASSWORD = ;

START=$(date +%s%N)

LOGIN_RESULT=$(
curl --location --silent --show-error \
--request PUT "http://debian1ph.iqb.hu-berlin.de/session/login" \
--data-raw '{"name":"loading_test","password":""}'
)

AUTH_TOKEN=$(jq -r '.token' <<< "$LOGIN_RESULT")


# the FE always runs a get session call after
#curl --location --silent --show-error \
#--request GET "http://debian1ph.iqb.hu-berlin.de/session" \
#--header "AuthToken: ""$AUTH_TOKEN"


TEST_NR=$(
curl --location --silent --fail --show-error \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request PUT "http://debian1ph.iqb.hu-berlin.de/test" \
--data-raw '{"bookletName":"BookletV8HT2022EngTHA"}'
)

 # Units (29)  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESINFOLAENDER | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESINFOLAENDER/alias/ESINFOLAENDER"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESLHSTART | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESLHSTART/alias/ESLHSTART"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESBSPMC-GIF | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESBSPMC-GIF/alias/ESBSPMC-GIF"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESBSPSA-GIF | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESBSPSA-GIF/alias/ESBSPSA-GIF"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESLBSPMM-DAD-GIF | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESLBSPMM-DAD-GIF/alias/ESLBSPMM-DAD-GIF"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESBSPCMC-GIF | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESBSPCMC-GIF/alias/ESBSPCMC-GIF"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESHAUDIOERKLAERUNG | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESHAUDIOERKLAERUNG/alias/ESHAUDIOERKLAERUNG"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESHINST | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESHINST/alias/ESHINST"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL614 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL614/alias/EL614"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL643 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL643/alias/EL643"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL602 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL602/alias/EL602"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL595 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL595/alias/EL595"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL596 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL596/alias/EL596"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESLINST-GIF | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESLINST-GIF/alias/ESLINST-GIF"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER554 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER554/alias/ER554"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER543 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER543/alias/ER543"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER533 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER533/alias/ER533"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESHWART | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESHWART/alias/ESHWART"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL619 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL619/alias/EL619"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL617 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL617/alias/EL617"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL615 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL615/alias/EL615"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | EL612 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/EL612/alias/EL612"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESHAUDIOENDE | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESHAUDIOENDE/alias/ESHAUDIOENDE"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESLWART | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESLWART/alias/ESLWART"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER547 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER547/alias/ER547"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER512 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER512/alias/ER512"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER552 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER552/alias/ER552"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ER542 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ER542/alias/ER542"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | unit | ESHLENDE | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/unit/ESHLENDE/alias/ESHLENDE"

 # Player (1)  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | player | IQB-PLAYER-ASPECT-1.15 | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/IQB-PLAYER-ASPECT-1.15?v=1"

 # Resources (29)  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESinfoLaender.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESinfoLaender.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESLHstart.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESLHstart.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESbspMC-Gif.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESbspMC-Gif.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESbspSA-Gif.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESbspSA-Gif.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESLbspMM-DaD-Gif.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESLbspMM-DaD-Gif.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESbspCMC-Gif.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESbspCMC-Gif.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESHaudioerklaerung.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESHaudioerklaerung.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESHinst.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESHinst.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL614.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL614.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL643.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL643.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL602.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL602.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL595.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL595.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL596.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL596.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESLinst-Gif.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESLinst-Gif.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER554.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER554.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER543.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER543.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER533.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER533.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESHwart.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESHwart.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL619.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL619.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL617.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL617.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL615.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL615.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | EL612.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/EL612.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESHaudioende.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESHaudioende.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESLwart.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESLwart.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER547.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER547.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER512.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER512.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER552.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER552.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ER542.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ER542.voud?v=f"
  
curl -o /dev/null --location --silent --fail --show-error \
-w "CALL | $AUTH_TOKEN | resource | ESHLende.voud | %{http_code} | $(date +%s%N) \n" \
--header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://debian1ph.iqb.hu-berlin.de/test/$TEST_NR/resource/ESHLende.voud?v=f"
END=$(date +%s%N)
echo "FINAL | $AUTH_TOKEN | Test $TEST_NR | $START | $END | " $(("$END" - "$START"))