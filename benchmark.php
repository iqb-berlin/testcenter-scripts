<?php

$repetitions = 20000;



$t1 = microtime(true);
for ($i = 0; $i < $repetitions; $i++) {
  echo "\n" . $i . "\t\t" . password_hash(hash_hmac('sha256', "abcdefg123$i", 'tc'), PASSWORD_BCRYPT, ['cost' => 4]);
}
$t2 = microtime(true);
$durationHash = ($t2 - $t1);



ini_set('memory_limit', '1G');

define('ROOT_DIR', realpath(__DIR__ . '/..'));
const DATA_DIR = ROOT_DIR . '/data';

require_once "vendor/autoload.php";

SystemConfig::read();
DB::connect();

$dao = new class extends DAO {
  function getPDO(): ?PDO {
    return $this->pdoDBhandle;
  }
};
$pdo = $dao->getPDO();
$dao->_('drop table if exists tmp');

$dao->_('create table tmp (password varchar(100) not null) collate = utf8mb3_german2_ci;');

$t1 = microtime(true);
for ($i = 0; $i < $repetitions; $i++) {
  $hash = "abcdefg123$i";
  echo "\n$hash";
  $dao->_('insert into tmp (password) values (?)', [$hash]);
}
$t2 = microtime(true);
$durationInsert = ($t2 - $t1);

$dao->_('drop table tmp');


// -

$dao->_('create table tmp (password varchar(100) not null) collate = utf8mb3_german2_ci;');

$t1 = microtime(true);
$sql = 'insert into tmp (password) values';
for ($i = 0; $i < $repetitions; $i++) {
  $hash = "abcdefg123$i";
  echo "\n$hash";
  $sql .= ' (' . $pdo->quote($hash) . '),';
}
$sql = rtrim($sql, ",");
$dao->_($sql);
$t2 = microtime(true);
$durationInsertAtOnce = ($t2 - $t1);

//$dao->_('drop table tmp');



echo "\n";
//echo "\n$durationHash sec for $repetitions hashes.\n";
echo "\n$durationInsert sec for $repetitions inserts.\n";
echo "\n$durationInsertAtOnce sec for $repetitions inserts combined.\n";