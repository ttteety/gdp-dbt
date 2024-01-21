# dbt-gdp

This project is used dbt to cleanse and load raw data into data marts.

## Prerquites

- Python 3.x
- Postgres DB


## Setting up a Virtual Environment
### 1. Install 'virtualenv'
If you don't have `virtualenv` installed, you can install it using the following command:

```
pip install virutalenv
```

### 2. Setup a Virtual Environment

```
virtualenv venv
```

### 3. Activate the Virtual Environment
On Windows:

```
venv\Scripts\activate
```

On macOS and Linux:

```
source venv/bin/activate
```

### 4. Clone this directory.

### 5. Install Project Dependencies

```
pip install -r requirements.txt
```

### 6. Setup a profile in dbt

Setup a profie call `gdp` to connect to PostgreSQL database in `.dbt/profiles.yaml`. The sample of the profile is as below:

```
gdp:
  outputs:
    dev:
      dbname: gdp_db
      host: localhost
      pass: password123
      port: 5432
      schema: gdp
      threads: 4
      type: postgres
      user: gdp_user
  target: dev

```
Ensure the profile is setup correctly from the command line:
```
dbt debug
```
### 8. Run dbt
Load the CSVs used for reference:
```
dbt seed
```
Run and test the models:
```
dbt build
```

### 9. Deactivate the Virtual Environment
When you're done working on the project, deactivate the virtual environment.

```
deactivate
```