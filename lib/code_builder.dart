import 'dart:io';
import 'package:path/path.dart';

import 'string_x.dart';

const indent = '  ';

String buildCode(String className, List<String> paths) {
  final bufferAll = StringBuffer();
  final main = buildClass(className, paths, bufferAll, true);
  bufferAll.writeln(main);
  return bufferAll.toString();
}

String buildClass(String className, List<String> paths, StringBuffer bufferAll, [bool top = false]) {
  final buffer = StringBuffer('class $className {')
    ..writeln()
    ..write(indent);

  if (top) {
    buffer..writeln('$className._();')..writeln();
  } else {
    buffer..writeln('const $className();')..writeln();
  }

  for (final p in paths) {
    final type = FileSystemEntity.typeSync(p);

    switch (type) {
      case FileSystemEntityType.directory:
        final directory = Directory(p);
        final name = split(directory.path).last;
        final className = '_Assets${name.pascalCase}';

        if (top) {
          buffer
            ..write(indent)
            ..writeln('static const ${name.camelCase} = $className();');
        } else {
          buffer
            ..write(indent)
            ..writeln('$className get ${name.camelCase} => $className();');
        }

        final res = buildClass(className, directory.listSync().map((e) => e.path).toList(), bufferAll);
        bufferAll.writeln(res);
        break;
      case FileSystemEntityType.file:
        buffer
          ..write(indent)
          ..writeln("String get ${basenameWithoutExtension(p).camelCase} => '$p';");
        break;
    }
  }

  buffer.writeln('}');
  return buffer.toString();
}
