# diff-patch

## Introduction

diff-patch is a library that exposes two functions, `diff` and `patch`.

The library does not have any dependencies.

The `diff` function takes two objects (`obj1` and `obj2`) and deep compares them, returning an object that represents the difference between the two (the `diffData`).
`diffData` is an object that can be used to apply the diff to `obj1` to get an object that is the same as `obj2`.

The `patch` function takes an `obj` and a `diffData` object and applies the diff to the object, returning a new object.

The `diff` and `patch` functions are implemented in the following languages:

  * TypeScript
  * Python3
  * Dart

The `diffData` object **can be used interchangeably between the languages**.\
This makes this library very useful for networked applications, where the client and server are written in different languages.

`diffData` can be serialized to JSON and deserialized back to an object. It aims to be as small as possible, and is designed to be used in a networked environment.

More languages will be added in the future, contributions are welcome.

## Usage

### TypeScript

To install the TypeScript version of diff-patch, run:

```bash
npm install @fsoft/diff-patch
```

Then, in your TypeScript code:

```typescript
import { diff, patch } from '@fsoft/diff-patch';

const obj1 = {
  a: 1,
  b: 2,
  c: {
    d: 3,
    e: 4,
  },
};

const obj2 = {
  a: 1,
  b: 2,
  c: {
    d: 3,
    e: 5,   // changed
  },
};

// create the diff data
const diffData = diff(obj1, obj2);

// show the diff data for debugging
console.log( "diffData: ", diffData);

// apply the diff data to obj1 to get an object that is the same as obj2
const obj3 = patch(obj1, diffData);

// show the result for debugging
console.log( "obj3: ", obj3);
```

### Python3

To install the Python3 version of diff-patch, run:

```bash
pip install fsoft-diff-patch
```

Then, in your Python code:

```python

from fsoft_diff_patch import diff, patch

obj1 = {
  'a': 1,
  'b': 2,
  'c': {
    'd': 3,
    'e': 4,
  },
}

obj2 = {
  'a': 1,
  'b': 2,
  'c': {
    'd': 3,
    'e': 5,   # changed
  },
}

# create the diff data
diff_data = diff(obj1, obj2)

# show the diff data for debugging
print("diff_data: ", diff_data)

# apply the diff data to obj1 to get an object that is the same as obj2
obj3 = patch(obj1, diff_data)

# show the result for debugging
print("obj3: ", obj3)
```

### Dart

To install the Dart version of diff-patch, run:

```bash
dart pub add fsoft_diff_patch
```

Then, in your Dart code:

```dart
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
```

### Hint

The `diff` function can be used to see if two objects are the same, by comparing the result of `diff` to an empty object.

```python
from diff_patch import diff

obj1 = {
  'a': 1,
  'b': 2,
  'c': {
    'd': 3,
    'e': 4,
  },
}

obj2 = {
  'a': 1,
  'b': 2,
  'c': {
    'd': 3,
    'e': 4,
  },
}

diff_data = diff(obj1, obj2)

# if the objects are the same, diff_data will be an empty object
if not diff_data:
  print("The objects are the same")
```

## Contributors

This library was created by [Fabio Rotondo](https://github.com/fsoft72).

New language implementations are more than welcome.\
Please open an issue or a pull request if you want to contribute.

**Collaborators**:

  * [Nikola Gluhovic](https://github.com/nini-os)


The official repository for this library is [here](https://github.com/fsoft72/diff-patch).

## License

This library is licensed under the MIT License.\
See the [LICENSE](LICENSE) file for details.
