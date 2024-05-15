FROM php:8.2.12

RUN echo '<?php' > /benchmark.php \
  && echo '$hashes = 20000; $t1 = microtime(true);' >> /benchmark.php \
  && echo 'for ($i = 0; $i < $hashes; $i++) { echo "\n" . $i . "\t\t" . password_hash(hash_hmac("sha256", "abcdefg123$i", "tc"), PASSWORD_BCRYPT, ["cost" => 4]);}' >> /benchmark.php \
  && echo '$t2 = microtime(true); $duration = ($t2 - $t1);' >> benchmark.php \
  && echo 'echo "\nDuration: $duration sec for $hashes \n";' >> benchmark.php

ENTRYPOINT ["php", "/benchmark.php"]