#!/bin/sh

echo y | fly -t main sp -p blog-m2 -c m2.yml -l ~/categolj3/credentials.yml
