import 'dart:convert';

/// Returns a diffData representing the difference between two JSON objects.
/// The diffData is an object containing only the differences between the two
/// objects. The patch can be applied to the original object using applyPatch
/// to produce the new object.
///
/// @param {Object} oldObject The original object
/// @param {Object} newObject The new object
/// @returns {Object} The diffData object
Map<String, dynamic> diff(dynamic oldObject, dynamic newObject) {
  var diffData = <String, dynamic>{};
  var keys = newObject.keys.toList();
  keys.forEach((key) {
    var oldValue = oldObject[key];
    var newValue = newObject[key];
    if (oldValue == null) {
      diffData[key] = newValue;
    } else if (newValue == null) {
      diffData[key] = null;
    } else if (newValue is Map) {
      var subPatch = diff(oldValue, newValue);
      if (subPatch.isNotEmpty) {
        diffData[key] = subPatch;
      }
    } else if (oldValue != newValue) {
      diffData[key] = newValue;
    }
  });
  // now scan oldObject keys and delete the ones that are not present in newObject
  keys = oldObject.keys.toList();
  keys.forEach((key) {
    if (!newObject.containsKey(key)) {
      diffData[key] = null;
    }
  });
  return diffData;
}

/// This function takes an object and a diffData object containing the
/// differences between the two objects, and returns a JSON object
/// containing the differences between the two objects.
/// The input object is the original object. The diffData object is the
/// object containing the differences between the two objects.
/// The returned object is the difference between the two objects.
///
/// @param {Object} oldObject The original object
/// @param {Object} diffData The diffData object
/// @returns {Object} The patched object
Map<String, dynamic> patch(dynamic oldObject, dynamic diffData) {
  var newObject = json.decode(json.encode(oldObject));
  var keys = diffData.keys.toList();

  keys.forEach((key) {
    var newValue = diffData[key];
    var keyNumber = int.tryParse(key) ?? -1;
    if (keyNumber >= 0) {
      if (keyNumber >= newObject.length) {
        newObject.add(newValue);
      } else {
        newObject[keyNumber] = patch(newObject[keyNumber], newValue);
      }
    } else {
      if (newValue == null) {
        newObject.remove(key);
        return;
      }
      if (!newObject.containsKey(key)) {
        newObject[key] = newValue;
        return;
      }
      if (newValue is Map) {
        newObject[key] = patch(newObject[key], newValue);
      } else {
        newObject[key] = newValue;
      }
    }
  });
  return newObject;
}
