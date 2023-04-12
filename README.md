# diff-patch

## Introduction

diff-patch is a library that exposes two functions, `diff` and `patch`.

The `diff` function takes two objects and deep compares them, returning an object that represents the difference between the two (the `diffData`).

The `patch` function takes an object and a diff object and applies the diff to the object, returning a new object.

The `diff` and `patch` functions are implemented in the following languages:

  * TypeScript
  * Python3

And the `diffData` object can be used interchangeably between the languages.

`diffData` can be serialized to JSON and deserialized back to an object. It aims to be as small as possible, and is designed to be used in a networked environment.

More languages will be added in the future, contributions are welcome.

## Usage

### TypeScript

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
```

### Python3

```python

from diff_patch import diff, patch

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
```


