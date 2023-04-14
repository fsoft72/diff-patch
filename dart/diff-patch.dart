import 'dart:convert';

Map<String, dynamic> diff(dynamic oldObject, dynamic newObject) {
  var patch = <String, dynamic>{};
  var keys = newObject.keys.toList();
  keys.forEach((key) {
    var oldValue = oldObject[key];
    var newValue = newObject[key];
    if (oldValue == null) {
      patch[key] = newValue;
    } else if (newValue == null) {
      patch[key] = null;
    } else if (newValue is Map) {
      var subPatch = diff(oldValue, newValue);
      if (subPatch.isNotEmpty) {
        patch[key] = subPatch;
      }
    } else if (oldValue != newValue) {
      patch[key] = newValue;
    }
  });
  // now scan oldObject keys and delete the ones that are not present in newObject
  keys = oldObject.keys.toList();
  keys.forEach((key) {
    if (!newObject.containsKey(key)) {
      patch[key] = null;
    }
  });
  return patch;
}

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
