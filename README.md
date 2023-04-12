# diff-patch

## Introduction

diff-patch is a library that exposes two functions, `diff` and `patch`.

The `diff` function takes two objects and deep compares them, returning an object that represents the difference between the two (the `diffData`).

The `patch` function takes an object and a diff object and applies the diff to the object, returning a new object.

The `diff` and `patch` functions are implemented in the following languages:

  * TypeScript
  * Python3

And the `diffData` object can be used interchangeably between the languages.

More languages will be added in the future, contributions are welcome.

