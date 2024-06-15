# Changelogs

## [3.1.0] - 2023-07-25
- upgrade packages

## [3.0.1] - 2022-10-23
- [breaking] migrate to dart 2.17.
- [breaking] unify to one single `WidgetWithCodeView` API
  - when `child` argument is null, will only show `SourceCodeView`.
  - See https://github.com/X-Wei/widget_with_codeview/issues/10.
- use [flutter_highlight](https://pub.dev/packages/flutter_highlight) for codeView
- add param `tabChangeListener` to listen tab switch event
- add param `headerWidget`/`footerWidget`
- add param `lightTheme`/`darkTheme` to specify code syntax highlighter theme.
- fix speedial style

## [2.0.1] - 2022-01-23
- Many improvements thanks to Agondev's [PR](https://github.com/X-Wei/widget_with_codeview/pull/11)
- Fix speedDial menu lable color [issue](https://github.com/X-Wei/flutter_catalog/issues/120).

## [2.0.0-nullsafe] - 2021-03-26

(Prerelease) Migrate to null safty. 
Many thanks to ryan-sf@!

## [1.0.5] - 2020-11-14

Use google_fonts package for source code view.

## [1.0.4] - 2020-11-08

Fix default tab controller.

## [1.0.3] - 2019-11-02

Fix zoom button behavior.

## [1.0.2] - 2019-10-19

Use SelectableText.rich() to make code selectable.

## [1.0.1] - 2019-07-27

Fix multiple heroes tag issue.

## [1.0.0] - 2019-07-22

Initial version: a small tweak from the MyRoute class in
<https://github.com/X-Wei/flutter_catalog.>
