import 'dart:convert';

import 'package:fsoft_diff_patch/fsoft_diff_patch.dart';

void main() {
  final a = {
    "a": 1,
    "b": 2,
    "c": {
      "d": 3,
      "e": 4,
      "f": {
        "g": 5,
        "h": 6,
      },
    },
  };
  final b = {
    "a": 1,
    // "b": 2, // b is deleted
    "c": {
      "d": 9, // d is changed
      "e": 4,
      "f": {
        "g": 5,
        "h": 7, // h is changed
        "i": 10, // i is added
      },
    },
  };
  // diff a and b and create a diffData object
  final diffData = diff(a, b);
  // print diffData in the console
  print("DIFF DATA\n${json.encode(diffData)}");
  // apply diffData to a and create a new object
  final patched_a = patch(a, diffData);
  // print patched_a in the console
  print("\n\nPATCHED OBJ\n${json.encode(patched_a)}");
  // check if patched_a is equal to b
  print("\n\nSAME OBJECT: ${json.encode(patched_a) == json.encode(b)}");
}
