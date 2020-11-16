import 'package:assets_gen/code_builder.dart';
import 'package:assets_gen/config_reader.dart';
import 'package:assets_gen/file_builder.dart';

void start() {
  final config = readConfig('pubspec.yaml');

  final content = buildCode(config.className, config);

  buildFile(config.outPath + config.fileName, content);
}
