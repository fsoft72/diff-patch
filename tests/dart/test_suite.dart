import 'dart:io';
import 'dart:convert';

import '../../dart/lib/fsoft_diff_patch.dart';

void main() {
  // for all directories in ../data directory, run the test
  var dataDir =
      Directory('../data');
  var dirs = dataDir
      .listSync()
      .where((e) => e is Directory)
      .map((e) => e.path)
      .toList()
      ..sort();

  for (final dir in dirs) {

    final dirName = dir.split("/").last;

    // write dir name, but keep the cursor at the same line
    stdout.write('Testing: $dirName ... ');

    final file01 = File('$dir/01.json');
    final file02 = File('$dir/02.json');

    // read file 01.json and 02.json from the directory
    final obj01 = jsonDecode(file01.readAsStringSync());
    final obj02 = jsonDecode(file02.readAsStringSync());

    // diff obj01 and obj02 and create a diffData object
    final diffData = diff(obj01, obj02);

    // apply diffData to obj01 and create a new object
    final patchedObj01 = patch(obj01, diffData);

    // check if patchedObj01 is equal to obj02
    if (jsonEncode(patchedObj01) != jsonEncode(obj02)) {
      print('FAILED');
    } else {
      print('OK');
    }
  }
  ;
}
