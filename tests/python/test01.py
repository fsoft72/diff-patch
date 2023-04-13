#!/usr/bin/env python3

import json
from fsoft_diff_patch import diff, patch

a = {
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
}

b = {
    "a": 1,
    # "b": 2,    # b is deleted
    "c": {
        "d": 9,  # d is changed
        "e": 4,
        "f": {
            "g": 5,
            "h": 7,  # h is changed
            "i": 10,  # i is added
        },
    },
}

# diff a and b and produce diff_data
diff_data = diff(a, b)

# print diff_data
print("DIFF DATA\n%s" % json.dumps(diff_data, indent=4))

# patch a with diff_data and produce patched_a
patched_a = patch(a, diff_data)

# print patched_a
print("\n\nPATCHED\n%s" % json.dumps(patched_a, indent=4))

# check if patched_a is equal to b
assert patched_a == b

print("\n\nSUCCESS")
