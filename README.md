# New Frontend for Openbis written in Nuxt

This frontend uses the prerelease version of OpenBIS 6.5 because this version brings TypeScript support.

## Prerequisites

Before getting started, make sure you have the following:

1. Install Node.js v21.7.1 from [Node.js Downloads](https://nodejs.org/en/download/package-manager)
2. Install Bun from [Bun.sh](https://bun.sh/)
3. Install Docker-Compose with [Docker-Compose Install](https://docs.docker.com/compose/install/)

## Backend Setup 

1. First, spin up the containers
```sh
docker-compose -f server/docker-compose.yml up
```

2. The files in `server/data` need to be copied to the OpenBIS server. These files come from [QBiC](https://portal.qbic.uni-tuebingen.de/portal/software).

3. Copy some Sample Data from the old test instance 
```sh
# Delete Database
docker exec -it openbis-db psql -U postgres -c "DROP DATABASE IF EXISTS openbis_prod;"
docker exec -it openbis-db psql -U postgres -c "DROP DATABASE IF EXISTS pathinfo_prod;"

# Create New Databases
docker exec -it openbis-db psql -U postgres -c "CREATE DATABASE openbis_prod OWNER openbis;"
docker exec -it openbis-db psql -U postgres -c "CREATE DATABASE pathinfo_prod OWNER openbis;"

# Copy data
docker cp /path/to/openbis_prod.sql.gz openbis-db:/openbis_prod.sql.gz
docker cp /path/to/pathinfo_prod.sql.gz openbis-db:/pathinfo_prod.sql.gz
docker cp /path/to/openbis_prod.sql openbis-db:/openbis_prod.sql
docker cp /path/to/pathinfo_prod.sql openbis-db:/pathinfo_prod.sql

# Integrate data
docker exec -it openbis-db bash -c "gunzip -c /openbis_prod.sql.gz | psql -U openbis -d openbis_prod"
docker exec -it openbis-db bash -c "gunzip -c /pathinfo_prod.sql.gz | psql -U openbis -d pathinfo_prod"
docker exec -it openbis-db psql -U openbis -d openbis_prod -f /openbis_prod.sql
docker exec -it openbis-db psql -U openbis -d pathinfo_prod -f /pathinfo_prod.sql
```

## Frontend Installation

Install dependencies with:

```sh
bun i
```

Make sure the ports 3000 and 54322 are accessible.

## Naming conventions

To prevent duplication and namespace collisions caused by auto-imports, use the `handle` prefix in `components`, such as `handleCreateCollection`. This approach helps maintain unique and clear function names.

## Testing

Because this applicaion is running on vuetify components, check out the [components in github](https://github.com/vuetifyjs/vuetify/tree/071eae762bc595f0c3bf9ff45a5926afaa3bbe3b/packages/vuetify/src/components) to get some testing impressions. The tests are under `__tests__` in each component file.



