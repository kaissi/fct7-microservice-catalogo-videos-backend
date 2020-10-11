#!/bin/bash

echo ">> Copying the generated Laravel files to the root project folder <<"

for file in $(ls -A .laravel-files-tmp); do
    mv .laravel-files-tmp/${file} ./
done \
&& rm -rf .laravel-files-tmp
