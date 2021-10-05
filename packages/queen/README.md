# Queen

# Motivation

Boilerplate code to save time for common tasks in day 2 day work

# Minimum Requirements

| key            | value  |
| -------------- | ------ |
| minSdkVersion  | 21     |
| kotlin_version | 1.4.32 |

# Usage

```YAML
dependencies:
queen:
   git:
    url: https://github.com/maxzod/queen.git
```

# Parts

- [x] context Less navigation (support embedded navigator but it requires context)
  - [ ] replace
  - [ ] to
  - [ ] replaceAll
- [x] localization (powered by easy_locaization)
  - [ ] String.tr
  - [ ] String.tr(args)
  - [ ] context.locale
  - [ ] context.setLocale
- [x] alerts (powered by edge_alerts)
  - [ ] alertWithSuccess(String)
  - [ ] alertWithErr(String)
- [ ] comma dialogs
