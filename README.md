# aspace-repo-move-tools

Tools that allow you to:

- Export a JSON file of almost all[^1] records from a repository in one ArchivesSpace instance
- Import that JSON file into another ArchivesSpace instance

Currently, this works great when the target instance does not contain any other repositories.

Further work is planned to improve the functionality for moving repositories from disparate ArchivesSpace instances into one instance.

- [Version](#version)
- [Setup](#setup)
  * [Reset](#reset)
- [Export usage](#export-usage)
  * [Testing export](#testing-export)
  * [Export multiple repositories from the same ArchivesSpace instance](#export-multiple-repositories-from-the-same-archivesspace-instance)
- [Import usage](#import-usage)
  * [Testing import](#testing-import)
  * [Import multiple repositories into the same ArchivesSpace instance](#import-multiple-repositories-into-the-same-archivesspace-instance)
- [All-in-one tester](#all-in-one-tester)
- [Dev](#dev)
- [Code history / credit](#code-history--credit)

## Version

It is recommended that source and target instances of ArchivesSpace use the same version.

Currently tested version: `v3.5.1`.

## Setup

Install [Java](#) & [Rbenv](#).

Then pull all of the project dependencies:

```bash
./resolve_deps.sh
```

In order for this to work, you need to use a monkey-patched version of the `streaming_import.rb` that changes the order in which things get created. Replace the `backend/app/lib/streaming_import.rb` file in your ArchivesSpace instance with the same-named file in this repository's `/support` directory.

### Reset

Use `./cleanup_deps.sh` to remove all downloaded dependencies then rerun setup.

## Export usage

```bash
./export.sh <source backend URL> <source repo id> <username> <password>
```

### Testing export

A convenient way of testing the export process is to target one of the public
ArchivesSpace test servers:

```bash
# download the "YNHSC" repository from test.archivesspace.org
./export.sh https://test.archivesspace.org/staff/api 2 admin admin
# download the "ATTracer" repository from test.archivesspace.org
./export.sh https://test.archivesspace.org/staff/api 3 admin admin
# download the "Space" repository from test.archivesspace.org
./export.sh https://test.archivesspace.org/staff/api 4 admin admin
# download the "test" repository from test.archivesspace.org
./export.sh https://test.archivesspace.org/staff/api 5 admin admin
```

The json output will be saved to the `export` folder as
`exported_<source repo id>.json`.

_Note: test.archivesspace.org is deployed from the ASpace `master` branch
and therefore should only be used with an ASpace src destination for import._

### Export multiple repositories from the same ArchivesSpace instance

One call of the `export_multi.rb` script and a config file can be used to batch all four of the exports in the previous code block. This script can be useful for testing or for projects involving multiple repositories.

First you need to create a config file containing the `id` and `repo_code` values of the repositories you wish to export. Use to format in the example file: `./support/multi_repo_config_sample.txt`.

Then:

```bash
cd support
ruby export_multi.rb https://test.archivesspace.org/staff/api admin admin multi_repo_config_sample.txt
```

A log file will be written to `support/export.log`.

Note: `export_multi.rb` calls the `./export.sh` script (which itself calls `lib/exporter.rb`). `./export.sh` is not returning the expected non-zero status code if `lib/exporter.rb` fails, so `support/export_multi.rb` shows failure messages, but then reports successful export.

## Import usage

```bash
./import.sh <target backend URL> <target repo id> <username> <password> <file to import>
```

### Testing import

A convenient way of testing the import process is to run a local
instance of ArchivesSpace using Docker:

```bash
docker-compose up --detach
```

_Note: the Docker instance uses a `release` version of ASpace and should only
be used to import data from a source using the same version._

Wait for ArchivesSpace to start then create a new repository:

```bash
./create_repository.sh <target backend url> <username> <password> <repository code>
./create_repository.sh http://localhost:8089 admin admin "test"
```

If that command is successful it will create a new repository and output the
response. Pay attention to the id:

```bash
{"status"=>"Created", "id"=>2, "lock_version"=>0, "stale"=>true, "uri"=>"/repositories/with_agent/2", "warnings"=>[]}
```

_Note: if you're creating one repository in an empty ArchivesSpace the id will be 2._

You can also view the list of available repositories:

```bash
./list_repositories.sh http://localhost:8089 admin admin
```

Next, proceed to import:

```bash
# import into local "test" repository
./import.sh http://localhost:8089 $repo_id admin admin exported_2.json
./import.sh http://localhost:8089 2 admin admin exported_2.json
```

_Note: the import file is expected to be in the `exports` folder. There is no
intrinsic relationship between the repository ids for source and destination._

Records should have been created in the local repository.

### Import multiple repositories into the same ArchivesSpace instance

One call of the `import_multi.rb` script and a config file can be used to batch run multiple imports. This script can be useful for testing or for projects involving multiple repositories.

First you need to create a config file containing the `id` and `repo_code` values of the repositories you wish to import. Use to format in the example file: `./support/multi_repo_config_sample.txt`. If you have used `export_multi.rb` to export multiple repositories for import elsewhere, you can use the same config file without changing it.

NOTES:

- Assumes you have not changed the names of exported .json files (Expects the `exported_{id}.json` form, where the id in the export file name matches the id in the config file)
- Creates the necessary repos in the target ArchivesSpace instance. Both the `repo_code` and `name` values of each created repository will be set to the code value in the config file.

Then:

```bash
cd support
ruby import_multi.rb http://localhost:4567 admin admin multi_repo_config_sample.txt
```

A log file will be written to `support/import.log`.

Note: `import_multi.rb` calls the `./import.sh` script (which itself calls `lib/importer.rb`). `./import.sh` is not returning the expected non-zero status code if `lib/importer.rb` fails, so `support/import_multi.rb` shows failure messages, but then reports successful import.

## All-in-one tester

Using ASpace src example. Setup and run ASpace from src, when ready:

```bash
./create_repository.sh http://localhost:4567 admin admin "test_2"
./create_repository.sh http://localhost:4567 admin admin "test_3"
./create_repository.sh http://localhost:4567 admin admin "test_4"
./create_repository.sh http://localhost:4567 admin admin "test_5"

./export.sh https://test.archivesspace.org/staff/api 2 admin admin
./export.sh https://test.archivesspace.org/staff/api 3 admin admin
./export.sh https://test.archivesspace.org/staff/api 4 admin admin
./export.sh https://test.archivesspace.org/staff/api 5 admin admin

./import.sh http://localhost:4567 2 admin admin exported_2.json
./import.sh http://localhost:4567 3 admin admin exported_3.json
./import.sh http://localhost:4567 4 admin admin exported_4.json
./import.sh http://localhost:4567 5 admin admin exported_5.json
```

## Dev

```bash
# rubocop linter
bundle exec rubocop lib/*.rb
# with autocorrect
bundle exec rubocop -a lib/*.rb
```

## Code history / credit

This code started off as a fork of [hudmol/repository-importer](https://github.com/hudmol/repository-importer), which was developed by [Hudson Molonglo Pty Ltd](https://hudsonmolonglo.com/).

[^1]: Currently some Event records are not moved as expected.
