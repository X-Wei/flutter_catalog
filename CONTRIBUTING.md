# CONTRIBUTING

## contribute by adding a new example page

1. Create a dart file under `lib/route/` (or just duplicate a file, e.g. `cp widgets_icon_ex.dart new_example.dart`);
2. In the new file, create an example widget;
3. In `my_app_routes.dart`, add a new `MyRoute` entry, with `child` being the example widget from last step;
4. Add other metadata like `sourceFilePath`,`title`, `description` and `links` to the `MyRoute` entry;
5. test run the app;
6. create a git pull request on github


## app release

### Android

```sh
# Copy dart defines to clipboard
$ define_env -c
# Build appbundle with the dart defines:
$ flutter build --dart-define=...
# Copy the built file to tmp/releases:
$ cp build/app/outputs/bundle/release/app-release.aab \
  tmp/releases/releases.link/flutter_catalog_va.b.c+dd.aab
```

### iOS
```sh
# Optional: re-install pod files
$ cd ios && pod install --repo-update && cd ..
# Copy dart defines to clipboard
$ define_env -c
# Build ipa with the dart defines:
$ flutter build ipa --release --dart-define=...
# Open the archive in XCode
$ open build/ios/archive/Runner.xcarchive
```