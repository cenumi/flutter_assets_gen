import 'package:assets_gen/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('build code', () {
    final code = buildCode('Assets', 'package_name', ['test/assets/dir1', 'test/assets/dir2'], 80);

    expect(code, '''
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
''');
  });

  test('build code without package name', () {
    final code = buildCode('Assets', null, ['test/assets/dir1', 'test/assets/dir2'], 80);

    expect(code, '''
// ignore_for_file: constant_identifier_names

// GENERATED CODE - DO NOT MODIFY BY HAND

class Assets {
  const Assets._();

  /// test/assets/dir1/as2.png
  static const String assets_dir1_as2 = "test/assets/dir1/as2.png";

  /// test/assets/dir1/as1.png
  static const String assets_dir1_as1 = "test/assets/dir1/as1.png";

  /// test/assets/dir2/as2.svg
  static const String assets_dir2_as2 = "test/assets/dir2/as2.svg";
}
''');
  });
}
