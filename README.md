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
(note that you need to install database-specific driver you need).

## LICENSE

This work is released under the MIT License.

IMDB datasets are provided for
[non-commercial use only](https://developer.imdb.com/non-commercial-datasets/).
