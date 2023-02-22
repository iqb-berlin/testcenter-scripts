#!/bin/bash

LOGIN_RESULT=$(
curl --location --silent --show-error \
--request PUT "http://localhost/testcenter/backend/session/login" \
--data-raw '{"name":"da09h223n","password":""}'
)

AUTH_TOKEN=$(echo $LOGIN_RESULT | jq -r ".token")

curl --location --silent --show-error \
--request GET "http://localhost/testcenter/backend/session" \
--header "AuthToken: ""$AUTH_TOKEN"

TEST_NR=$(
curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request PUT "http://localhost/testcenter/backend/test" \
--data-raw '{"bookletName":"L5.P22.MA01"}'
)

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5M_Start/alias/L5M_Start"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/IQB-PLAYER-ASPECT@1.20.HTML?v=1"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_Hinweise/alias/L5MA_Hinweise"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_bspMC/alias/L5MA_bspMC"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_bspTF_Ergebnis/alias/L5MA_bspTF_Ergebnis"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_bspTF_Rechnung/alias/L5MA_bspTF_Rechnung"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_bspDD/alias/L5MA_bspDD"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_Start/alias/L5MA_Start"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV19112_001/alias/L5ZV19112_001"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14144_002a/alias/L5ZV14144_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14133_002a/alias/L5ZV14133_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14138_012b/alias/L5ZV14138_012b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18256_002b/alias/L5ZV18256_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18316_003/alias/L5ZV18316_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV19308_003/alias/L5ZV19308_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18263_002b/alias/L5ZV18263_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV22101_001/alias/L5ZV22101_001"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14122_001/alias/L5ZV14122_001"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV15212_002a/alias/L5ZV15212_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18270_002b/alias/L5ZV18270_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14184_023/alias/L5ZV14184_023"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18305_003/alias/L5ZV18305_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV16251_002b/alias/L5ZV16251_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV19201_002a/alias/L5ZV19201_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_Pause/alias/L5MA_Pause"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV19121_001a/alias/L5OV19121_001a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV16005_001a/alias/L5OV16005_001a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV14123_011b/alias/L5OV14123_011b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV14113_022/alias/L5OV14113_022"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV15331_003/alias/L5OV15331_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV17303_003/alias/L5OV17303_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV17304_003/alias/L5OV17304_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV17201_002/alias/L5OV17201_002"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV15002_001a/alias/L5OV15002_001a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV14122_001b/alias/L5OV14122_001b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV19161_001b/alias/L5OV19161_001b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV15220_002/alias/L5OV15220_002"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV14069_013/alias/L5OV14069_013"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV17322_003/alias/L5OV17322_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV17310_003/alias/L5OV17310_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5OV17203_002/alias/L5OV17203_002"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5MA_Pause2/alias/L5MA_Pause2"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV22100_001/alias/L5ZV22100_001"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14129_011/alias/L5ZV14129_011"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14131_002a/alias/L5ZV14131_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV19268_002b/alias/L5ZV19268_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14138_023/alias/L5ZV14138_023"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV19306_003/alias/L5ZV19306_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV16219_002a/alias/L5ZV16219_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18114_001/alias/L5ZV18114_001"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18100_001/alias/L5ZV18100_001"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14125_002a/alias/L5ZV14125_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18217_002a/alias/L5ZV18217_002a"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14136_012b/alias/L5ZV14136_012b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV14107_022b/alias/L5ZV14107_022b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18310_003/alias/L5ZV18310_003"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18274_002b/alias/L5ZV18274_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5ZV18257_002b/alias/L5ZV18257_002b"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/unit/L5_Ende/alias/L5_Ende"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5M_Start.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_Hinweise.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_bspMC.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_bspTF_Ergebnis.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_bspTF_Rechnung.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_bspDD.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_Start.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV19112_001.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14144_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14133_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14138_012b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18256_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18316_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV19308_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18263_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV22101_001.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14122_001.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV15212_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18270_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14184_023.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18305_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV16251_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV19201_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_Pause.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV19121_001a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV16005_001a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV14123_011b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV14113_022.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV15331_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV17303_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV17304_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV17201_002.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV15002_001a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV14122_001b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV19161_001b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV15220_002.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV14069_013.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV17322_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV17310_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5OV17203_002.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5MA_Pause2.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV22100_001.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14129_011.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14131_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV19268_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14138_023.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV19306_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV16219_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18114_001.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18100_001.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14125_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18217_002a.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14136_012b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV14107_022b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18310_003.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18274_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5ZV18257_002b.voud?v=f"

curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
--request GET "http://localhost/testcenter/backend/test/$TEST_NR/resource/L5_Ende.voud?v=f"



