Usage:

Append following to pubspec.yaml:

```yaml
assets_gen:
  out_path: gen/ #optional 
  file_name: assets.dart #optional
  class_name: Assets #optional
  line_width: 80 #optional
```

Consider:

```yaml
flutter:
  assets:
    - dir1/
    - dir2/
```

Folder structure like [test](test/assets)

Generates:

```dart
// ignore_for_file: constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

class Assets {
  const Assets._();

  /// test/assets/dir1/as2.png
  static const String assets_dir1_as2 =
      "packages/package_name/test/assets/dir1/as2.png";

  /// test/assets/dir1/as1.png
  static const String assets_dir1_as1 =
      "packages/package_name/test/assets/dir1/as1.png";

  /// test/assets/dir2/as2.svg
  static const String assets_dir2_as2 =
      "packages/package_name/test/assets/dir2/as2.svg";
}
```



