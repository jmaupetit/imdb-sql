# IMDB SQL

Load IMDB datasets in a SQL database.

## 💡 The idea

**TL;DR** this project aims to be a helper to generate massive databases used in
performance-related studies. It is actually used in the
[data7 project](https://jmaupetit.github.io/data7/).

## Dependencies

- [Poetry](https://python-poetry.org)
- [Curl](https://curl.se/)
- [GNU Make](https://www.gnu.org/software/make/)

## Getting started

Clone the project then bootstrap it using:

```sh
make bootstrap
```

And you are now ready to push the dataset to your database:

```sh
poetry run python imdb-sql.py [DATABASE_URL]
```

With no argument, this will create an `im.db` SQLite database in the current
directory. Feel free to add the `DATABASE_URL` argument to use a PostgreSQL or
MariaDB instance. We support database URLs as defined in
[SQLAlchemy](https://docs.sqlalchemy.org/en/20/core/engines.html#database-urls)
(note that you need to install required database-specific driver).

## Testing with other DBMS

We provide a Docker compose configuration to test datasets loading in other DBMS
than SQLite.

> 💡 Feel free to substitute provided docker-based configuration with the
> database server instance used in performance tests.

### PostgreSQL

Boot the Postgres server (if you need one, else use your own server):

```sh
docker compose up -d postgresql
```

Install the Postgres driver:

```sh
poetry add psycopg2-binary
```

Load IMDB datasets:

```sh
poetry run python imdb-sql.py postgresql://imdb:pass@localhost:5432/imdb
```

### MariaDB

Boot the MariaDB server (if you need one, else use your own server):

```sh
docker compose up -d mariadb
```

Install the MariaDB driver (you should first install MariaDB on your system):

```sh
poetry add mariadb
```

Load IMDB datasets:

```sh
poetry run python imdb-sql.py mariadb://imdb:pass@localhost:3306/imdb
```

## LICENSE

This work is released under the MIT License.

IMDB datasets are provided for
[non-commercial use only](https://developer.imdb.com/non-commercial-datasets/).
