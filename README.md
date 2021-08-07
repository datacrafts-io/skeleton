# Skeleton

Create new apps quickly!

## Installation

Install this gem as follow:

    $ gem install datacrafts-io-skeleton


## Usage

This command will create new Rails app with configured extensions, rails_helper.rb for RSpec and .rubocop.yml.
All major gems are also included.

    $ datacrafts-io-skeleton create APP_NAME [EXTENSIONS]

Use `help` to get the list of extensions allowed to install
```
$ datacrafts-io-skeleton help create
  Usage:
    datacrafts-io-skeleton create APP_NAME

  Options:
    r, [--react=one two three]                      # Adds React.js to your project
                                                    # Possible values: typescript
    v, [--vue=one two three]                        # Adds Vue.js to your project
                                                    # Possible values:
                                                      typescript, eslint, router,
                                                      pwa, vuex, jest
    d, [--database=DATABASE]                        # Select type of database for your app
                                                    # Default: postgresql
                                                    # Possible values:
                                                      mysql, postgresql,
                                                      sqlite3, oracle, sqlserver,
                                                      jdbcmysql, jdbcsqlite3,
                                                      jdbcpostgresql, jdbc
    c, [--dockerize], [--no-dockerize]              # Wraps your application to docker containers w/ docker-compose
    i, [--dry-initializer], [--no-dry-initializer]  # Adds dry-initializer to your config
                                                    # Default: true

  Create you own best Rails/JS app
```

## Extensions

1. `--dry-initializer` ([Dry::Initializer](https://dry-rb.org/gems/dry-initializer/3.0/)):  adds gem to Rails Gemfile, creates basic ApplicationService.
2. `--database`: in case of `postgresql` and `mysql` installs additional gems with initializers and config files ([strong_migrations](https://github.com/ankane/strong_migrations), [activerecord-clean-db-structure](https://github.com/lfittl/activerecord-clean-db-structure), and [activerecord-safer_migrations](https://github.com/gocardless/activerecord-safer_migrations))
3. `--vue`: creates Vue.js frontend application inside `${APP_DIR}/frontend` with selected plugins
4. `--react`: creates React.js frontend application inside `${APP_DIR}/frontend` from choosen template
5. `--dockerize`: wraps your applications to docker containers using `docker` and `docker-compose`

---
**Note that for `Rails` you're need installed `ruby`**

**For frontend frameworks - `Node.js`**

**For Dockerizing - `docker` w/ `docker-compose`**

---

## Examples

    $ datacrafts-io-skeleton create awesome --database=sqlite3 --vue --dry-initializer
> Will create Rails application inside `awesome` directory with gems and adapters for `sqlite3`, gem `dry-initializer` with base `ApplicationService` inside `app/services` directory and also creates Vue.js application inside `awesome/frontend` with default config (no plugins passed).


    $ datacrafts-io-skeleton create awesome --database=postgresql --vue=jest typescript eslint --no-dry-initializer
> Will create Rails application inside `awesome` directory with gems and adapters for `Postgres`, adds gems for migrations and database health, skips installing `dry-initializer` and creates Vue.js app inside `awesome/frontend` with Jest, Typescript and ESlint.

    $ datacrafts-io-skeleton create awesome --database=mysql --react=typescript --dockerize
> Will create Rails application inside `awesome` directory with gems and adapters for `MySQL`, adds gems for migrations and database health, installs `dry-initializer` with basic `ApplicationService` and creates React.js app inside `awesome/frontend` from template [`cra-template-typescript`](https://www.npmjs.com/package/cra-template-typescript). In addition it will create `docker` directory with Dockerfiles and entrypoints for containers and `docker-compose.yml` in root so you'll need only update `.env`, `database.yml` and run `docker-compose up`.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at [datacrafts-io/skeleton](https://github.com/datacrafts-io/skeleton). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/datacrafts-io/skeleton/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Skeleton project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/datacrafts-io/skeleton/blob/master/CODE_OF_CONDUCT.md).
