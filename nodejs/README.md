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
