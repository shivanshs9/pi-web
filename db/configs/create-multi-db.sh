#!/bin/bash

set -eu

function create_user_and_database() {
    local dbinfo=$1
    IFS=":" read -r database owner password <<< "$dbinfo"

    echo "Creating user and database '$database' with user '$owner'."
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
        DO
            \$do\$
            BEGIN
            IF NOT EXISTS ( SELECT FROM pg_roles  
                            WHERE  rolname = '$owner') THEN
                CREATE USER $owner;
                ALTER USER $owner WITH ENCRYPTED PASSWORD '$password';
            END IF;
            END
            \$do\$;
        CREATE DATABASE $database;
        GRANT ALL PRIVILEGES ON DATABASE $database TO $owner;
        \c $database
        GRANT ALL ON schema public TO $owner;
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
    echo "Multiple database creation requested: $POSTGRES_MULTIPLE_DATABASES"
    for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
        create_user_and_database $db
    done
    echo "Multiple databases created"
fi
