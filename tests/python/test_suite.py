import os
import json

from fsoft_diff_patch import diff, patch

# for all directories in ../data directory, run the test
data_dir = os.path.join(os.path.dirname(__file__), '../data')
dirs = sorted(os.listdir(data_dir))

for dir in dirs:
    # write dir name, but keep the cursor at the same line
    print(f"Testing: {dir} ... ", end="")

    file01 = os.path.join(data_dir, dir, '01.json')
    file02 = os.path.join(data_dir, dir, '02.json')

    # read file 01.json and 02.json from the directory
    with open(file01, 'r') as f:
        obj01 = json.load(f)
    with open(file02, 'r') as f:
        obj02 = json.load(f)

    # diff obj01 and obj02 and create a diffData object
    diff_data = diff(obj01, obj02)

    # apply diffData to obj01 and create a new object
    patched_obj01 = patch(obj01, diff_data)

    # check if patched_obj01 is equal to obj02
    if json.dumps(patched_obj01) != json.dumps(obj02):
        print("FAILED")
    else:
        print("OK")