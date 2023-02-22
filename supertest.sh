#!/bin/bash
echo "# testing it!"

rm supertest.log
touch supertest.log
chmod 777 supertest.log

#exec >supertest.log 2>&1

sudo tc qdisc add dev lo root netem delay 100ms 1ms

echo "delete from login_sessions;" | mysql --user=root --password=somesql testcenter_monorepo

for i in {1..35}; do
  . test.sh $i &
done
wait

sudo tc qdisc del dev lo root netem delay 100ms 1ms

#exec > /dev/tty 2>&1

echo "log:"

cat supertest.log

echo "----"

echo "login_sessions: " $(echo "select count(*) from login_sessions" | mysql --user=root --password=somesql testcenter_monorepo)
echo "person_sessions: " $(echo "select count(*) from person_sessions" | mysql --user=root --password=somesql testcenter_monorepo)
echo "suffixes: " $(echo "select concat(name_suffix) from person_sessions" | mysql --user=root --password=somesql testcenter_monorepo)