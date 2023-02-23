<?php
$envFileDir = getenv('ENV_FILE_DIR');
$envFile = "$envFileDir/environment.ts";
$env = file_get_contents($envFile);
$ip = explode(' ', getenv('IPADRRESSES'))[0];
$backendUrl = str_replace('localhost', $ip, getenv('TC_API_URL'));
$newEnv = preg_replace('#(testcenterUrl:\s?[\"\'])(.*?)([\"\'])#', "$1$backendUrl/$3", $env);
$newEnv = str_replace('http://', 'https://', $newEnv);
file_put_contents($envFile, $newEnv);
echo "\n Running on http://$ip:4200 \n";