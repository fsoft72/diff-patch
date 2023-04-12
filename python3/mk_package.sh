#!/bin/bash

rm -Rf build *.egg-info dist
python3 setup.py sdist bdist_wheel
twine upload dist/*
