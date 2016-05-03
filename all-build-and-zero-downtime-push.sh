#!/bin/sh

dir="$dir eureka-server"
dir="$dir hystrix-dashboard"
dir="$dir blog-api"
#dir="$dir blog-ui"
dir="$dir blog-kotlin-ui"
dir="$dir feed"

for d in $dir; do
    pushd $d > /dev/null
        app=`grep name: manifest.yml | awk '{print $3}'`
        mvn clean package -Dmaven.test.skip=true
        cf zero-downtime-push $app -f manifest.yml
    popd > /dev/null
done
