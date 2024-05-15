<?php

// docker compose -f docker-compose.yml -f docker-compose.prod.yml run -v /home/iqb/testcenter/benchmark.php:/benchmark.php --entrypoint='' testcenter-backend php /benchmark.php

$hashes = 20000;
$t1 = microtime(true);
for ($i = 0; $i < $hashes; $i++) {
  echo "\n" . $i . "\t\t" . password_hash(hash_hmac('sha256', "abcdefg123$i", 'tc'), PASSWORD_BCRYPT, ['cost' => 4]);
}
$t2 = microtime(true);
$duration = ($t2 - $t1);
echo "\nDuration: $duration sec for $hashes \n";