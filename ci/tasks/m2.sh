
#/bin/sh

M2REPO=`pwd`/m2/rootfs/opt/m2


DIR="$DIR eureka-server"
DIR="$DIR blog-api"
DIR="$DIR blog-ui"
DIR="$DIR blog-kotlin-ui"
DIR="$DIR feed"
DIR="$DIR hystrix-dashboard"


if [ "$1" == "init" ]; then
	mkdir -p $M2REPO
fi

cd repo
	for d in $DIR;do
	    echo "++++ Build $d ++++"
	    cd $d
	        ./mvnw clean package -Dmaven.repo.local=$M2REPO
	    cd ..
	done
cd ..

cd m2
	tar -C rootfs -cf rootfs.tar .
	mv rootfs.tar ../to-push
cd ..