# repository-importer

Script to get all archival records for a repository and build an importable JSON file.

## Version

It is recommended that source and target instances of ArchivesSpace use the same version.

Currently tested version: `v3.2.0`.

## Setup

Begin by pulling all of the project dependencies:

```bash
./resolve_deps.sh
```

### Reset

Use `./cleanup_deps.sh` to remove all downloaded dependencies & rerun setup.

## Export usage

```bash
./export.sh <source backend URL> <source repo id> <username> <password>
```

### Testing export

A convenient way of testing the export process is to target one of the public
ArchivesSpace test servers:

```bash
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

Wait for ArchivesSpace to start then create a new repository. After that:

```bash
# import into "local" test repository
./import.sh http://localhost:8089 2 admin admin ./exports/exported_5.json
```

Records should be created in the local repository.
