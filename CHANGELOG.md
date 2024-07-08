Before release:
- return back all example localizations
- unmark example as excluded
- generate the lib for example

Tasks:
- handle country code: en_US / en_UK / en_CA +
- camelCase-ization of all string keys when creating variables
- merge different translations
  - can use one as a primary, and change fields in another, only those, what presents +
  - including for a remote source
- ???

## Changelog

- 2.0.0 - Added localization providers for loading localizations remotely. Ability to merge different languages and several variations of the same language
- 1.0.3 - Hotfix
- 1.0.2 - Screening of variable names in dynamic objects
- 1.0.1 - Small fixes due to flutter analyze
- 1.0.0 - Style fixes for pub.dev analysis and some logic fixes for codegen
- 0.0.2 - Release with all code-generation features, including genders
- 0.0.1 - Initial release
