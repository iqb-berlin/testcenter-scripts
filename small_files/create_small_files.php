<?php
$i= 0;
while ($i++ < 150) {
  file_put_contents(__DIR__ . "test$i.txt", 'x');
}