#!/bin/sh
git submodule foreach git pull origin master
git add -A
git commit -m "Update"
git push origin master
