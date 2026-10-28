import 'dart:io';
import 'package:test/test.dart';

void main() {
  test('lib/domain must not import flutter or flame', () {
    final domainDir = Directory('lib/domain');
    if (!domainDir.existsSync()) {
      return; // Not created yet
    }

    final dartFiles = domainDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));

    for (final file in dartFiles) {
      final content = file.readAsStringSync();
      final lines = content.split('\n');
      for (int i = 0; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.startsWith('import ') || line.startsWith('export ')) {
          if (line.contains("'package:flutter/") ||
              line.contains('"package:flutter/') ||
              line.contains("'package:flame/") ||
              line.contains('"package:flame/')) {
            fail(
                'File ${file.path} at line ${i + 1} imports flutter or flame:\n$line');
          }
        }
      }
    }
  });
}
