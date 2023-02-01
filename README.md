# Redmine
Redmine is a flexible project management web application written using Ruby on Rails framework.

More details can be found in the doc directory or on the official website http://www.redmine.org

## Installation
*This installation is for setting up development of this Redmine repository using WSL2 or Linux (Debian based distros)*

### Step 1: Ruby on Rails
Follow [this tutorial](https://www.vultr.com/docs/installing-ruby-on-rails-on-ubuntu-20-04/) to get Ruby and Rails installed.

### Step 2: Setup PostgreSQL in Docker
For development, setup a PostgreSQL server with Docker Compose (Docker needs to be installed) with the command:
```bash
./scripts/postgres-up.sh
```

### Step 3: Installing project dependencies
To be able to install `pg`, the following dependencies need to be installed: 
```bash
sudo apt install postgresql-contrib libpq-dev1
```

Then `RMagick` needs to be enabled, which needs the following dependencies:
```bash
sudo apt install pkg-config
sudo apt install imagemagick
sudo apt install libmagick++-dev
```

After RMagick can be installed with:
```bash
gem install rmagick
```

The following command then installs the project dependencies for development:
```bash
bundle install
```

*For production the command is slightly different:*
```bash
BUNDLER_WITHOUT="development test" bundle install
```

### Step 4: Session store secret generation

This step generates a random key used by Rails to encode cookies storing session data thus preventing their tampering. Generating a new secret token invalidates all existing sessions after restart.
```bash
bundle exec rake generate_secret_token
```

### Step 5: Database schema objects creation
Create the database structure, by running the following command under the application root directory:
```bash
RAILS_ENV=development bundle exec rake db:migrate
```

*For production the command is slightly different:*
```bash
RAILS_ENV=production bundle exec rake db:migrate
```

#### **Getting errors on database migration**
In some cases (e.g. switching between production and development environment) the bundles need to be installed anew. The following commands can be run to renew the bundle installation:
```bash
bundle config --delete without
bundle config --delete with
bundle install
```

### Step 6: Database default data set
Insert default configuration data in database, by running the following command:
```bash
RAILS_ENV=development bundle exec rake redmine:load_default_data
```

*For production the command is slightly different:*
```bash
RAILS_ENV=production bundle exec rake redmine:load_default_data
```

### Step 7: File system permissions
The user account running the application must have write permission on the following subdirectories:
```bash
mkdir -p tmp tmp/pdf public/plugin_assets
sudo chown -R <username>:<username> files log tmp public/plugin_assets
sudo chmod -R 755 files log tmp public/plugin_assets
```

## Running development server
The server can be run with the command:

```bash
./scripts/run.sh
```

_If database has not started before `run.sh`_, execute:
```bash
./scripts/postgres-up.sh
```

This command starts server running on port 3000 accessible via [localhost:3000](localhost:3000).

Use default administrator account to log in:
- login: admin
- password: admin (after setup: Administrator)