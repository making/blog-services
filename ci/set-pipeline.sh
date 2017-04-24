#!/bin/sh

echo y | fly -t home sp -p blog-m2 -c m2.yml -l ~/categolj3/credentials.yml
