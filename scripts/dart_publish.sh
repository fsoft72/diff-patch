#!/bin/bash

# if the `dart` folder is not in the current path, try to move to the parent folder
if [ ! -d "dart" ]; then
    cd ..
fi

# if the `dart` folder is not in the current path, exit
if [ ! -d "dart" ]; then
    echo "Could not find the 'dart' folder"
    exit 1
fi

# enter the `dart` folder
cd dart

dart analyze

# if analysis fails, exit
if [ $? -ne 0 ]; then
    echo "Please check the analysis errors"
    exit 1
fi

# publish in dry-run
dart pub publish --dry-run

# if dry-run fails, exit
if [ $? -ne 0 ]; then
    echo "Please check the dry-run errors"
    exit 1
fi

# If we get here, everything is fine, so publish
dart pub publish