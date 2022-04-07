# repository-importer

Script to get all archival records for a repository and build an importable JSON file.

## Version

It is recommended that source and target instances of ArchivesSpace use the same version.

Currently tested version: `v3.2.0`.

## Setup

Install [Java](#) & [Rbenv](#).

Then pull all of the project dependencies:

```bash
./resolve_deps.sh
```

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

Next, proceed to import:

```bash
# import into local "test" repository
./import.sh http://localhost:8089 $repo_id admin admin exported_4.json
./import.sh http://localhost:8089 2 admin admin exported_4.json
```

_Note: the import file is expected to be in the `exports` folder. There is no
intrinsic relationship between the repository ids for source and destination
(in the example source repository id 4 is imported into destination repository
id 2)._

Records should be created in the local repository.
