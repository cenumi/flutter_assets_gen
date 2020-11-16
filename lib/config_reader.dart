import 'dart:io';

import 'package:yaml/yaml.dart';

class Config {
  String outPath = 'gen/';
  String fileName = 'assets.dart';
  String className = 'Assets';
  String package;
  List<String> paths = [];

  @override
  String toString() {
    return 'Config{outPath: $outPath, fileName: $fileName, className: $className, paths: $paths}';
  }
}

Config readConfig(String filePath) {
  final file = File(filePath);
  final yaml = loadYaml(file.readAsStringSync());
  final res = Config();

  final assets = yaml['flutter']['assets'];

  for (final a in assets) {
    res.paths.add(a);
  }

  final config = yaml['assets_gen'];
  if (config == null) {
    return res;
  }
  final package = config['package'];
  final outPath = config['out_path'];
  final fileName = config['file_name'];
  final className = config['class_name'];

  if (package != null) {
    res.package = package;
  }

  if (outPath != null) {
    res.outPath = outPath;
  }

  if (fileName != null) {
    res.fileName = fileName;
  }

  if (className != null) {
    res.className = className;
  }

  return res;
}
