import 'dart:io';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart';

import 'string_x.dart';

String buildCode(String className, String? packageName, List<String> paths, int lineWidth) {
  final cls = Class((c) {
    c.docs.addAll([
      '// ignore_for_file: constant_identifier_names\n',
      '// GENERATED CODE - DO NOT MODIFY BY HAND\n\n',
    ]);
    c.name = className;
    c.constructors.add(Constructor((constructor) {
      constructor.constant = true;
      constructor.name = '_';
    }));

    for (final path in paths) {
      c.fields.addAll(buildLines(path, packageName));
    }
  });

  final emitter = DartEmitter(useNullSafetySyntax: true, orderDirectives: true);

  return DartFormatter(pageWidth: lineWidth).format('${cls.accept(emitter)}');
}

List<Field> buildLines(String path, String? package) {
  final type = FileSystemEntity.typeSync(path);

  final lines = <Field>[];

  switch (type) {
    case FileSystemEntityType.directory:
      print('building: $type: $path');
      final dir = Directory(path);
      for (final innerPath in dir.listSync().map((e) => e.path)) {
        lines.addAll(buildLines(innerPath, package));
      }

      break;
    case FileSystemEntityType.file:
      if (path.contains('.DS_Store')) break;
      print('building: $type: $path');
      lines.add(Field((field) {
        field.docs.add('/// $path');
        field.static = true;
        field.modifier = FieldModifier.constant;
        field.name = relative(withoutExtension(path), from: split(path).first).snakeCase;
        field.type = refer('String');
        if (package == null) {
          field.assignment = Code('"$path"');
        } else {
          field.assignment = Code('"packages/$package/$path"');
        }
      }));
      break;
    default:
      break;
  }

  return lines;
}
