# ArchivesSpace Configuration Manager

## Getting Started

```bash
bundle install
cd dist
git clone https://github.com/archivesspace/archivesspace.git
cd -
```

## Using the CLI
```bash
bundle exec thor locales:build
```

One additional step which may be of value is to lint the YAML files:
```
yarn global add prettier
prettier --write build/common/locales/**/*yml
```

## Using Capistrano
```bash
bundle exec cap development locales:push
```

## Uploading the Configuration Files

```bash
rsync \
  --archive \
  --update \
  --verbose \
  --compress \
  --itemize-changes \
  --human-readable \
  --partial \
  --rsh="ssh -p 22" \
  build/common/locales \
  aspace@archivesspace.localhost:/opt/archivesspace/
```
