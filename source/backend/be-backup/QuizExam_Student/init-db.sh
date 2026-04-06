#!/bin/bash

CONTAINER_NAME="quiz-exam-db"
DB_NAME="db_test"
DB_USER="root"
DB_PASS="12345678"

echo "Starting import of db.sql into $DB_NAME..."

docker exec -i $CONTAINER_NAME mysql -u $DB_USER -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

cat db.sql | docker exec -i $CONTAINER_NAME mysql -u $DB_USER -p"$DB_PASS" $DB_NAME

if [ $? -eq 0 ]; then
    echo "Import successful."
else
    echo "Import failed. Check credentials or SQL syntax."
fi
