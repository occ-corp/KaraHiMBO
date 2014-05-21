KaraHi MBO
====================

KaraHi MBO is a data entry system for MBO.

Management by Objectives (MBO) is a process of defining objectives within an organization so that management and employees agree to the objectives and understand what they need to do in the organization.

See http://en.wikipedia.org/wiki/Management_by_objectives for more details.

Requirements
--------------------

* Debian GNU/Linux 6.0
* Ruby on Rails 2.3.12
* Ruby 1.8.7
* PostgreSQL 8.4
* SQLite3 (Development)

Getting Started
--------------------

Install dependency gems.

    $ bundle install --path vendor/bundle

Initialize the database.

    $ vi config/database.yml
    $ bundle exec rake db:migrate

Load fixtures into the database.

    $ bundle exec rake db:fixtures:load

Test the installation by running WEBrick web server.

    $ bundle exec ruby script/server

Open your browser with http://localhost:3000. You will see the application welcome page.

Use default administrator account to log in:

| field    | param      |
|----------|------------|
| login    | `admin`    |
| password | `P@ssw0rd` |

LICENSE
--------------------

MBO on Rails is free software licensed under AGPL V3.
See [LICENSE.txt](LICENSE.txt) for more information.

CONTACT
--------------------

OCC Corporation. http://www.occ.co.jp
