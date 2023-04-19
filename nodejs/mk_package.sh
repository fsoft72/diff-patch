#!/bin/bash

npm version patch
npm run build
#npm login
npm publish --access public