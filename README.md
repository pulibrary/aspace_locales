
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

## Using Capistrano
```bash
bundle exec cap development locales:push
```
