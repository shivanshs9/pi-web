## Setting up Postgres
1. Using a specialized postgres image: `tensorchord/pgvecto-rs`
2. Run following commands as immich's DB user:
```postgresql
CREATE EXTENSION cube;
CREATE EXTENSION earthdistance;
CREATE EXTENSION vectors;
```
3. If you get migration errors related to vectors, your app's DB user should be owner of the database and the vectors extension. If you fail to create vectors extension as app user, refer to [this github issue to gain superuser perms.](https://github.com/immich-app/immich/issues/5399#issuecomment-1833533765)
