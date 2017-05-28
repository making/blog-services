#/bin/sh

BASEDIR=`pwd`
M2REPO=${BASEDIR}/m2/rootfs/opt/m2

DIR="$DIR blog-domain"
DIR="$DIR blog-mapper"
DIR="$DIR blog-api"
DIR="$DIR blog-kotlin-ui"
DIR="$DIR blog-webhook"
DIR="$DIR blog-updater"
#DIR="$DIR feed"



if [ "$1" == "init" ]; then
	mkdir -p $M2REPO
fi

cd repo
ls -la
	for d in $DIR;do
		${BASEDIR}/utils/scripts/add-repos-in-pom-xml.sh ${d}
	    echo "++++ Build $d ++++"
	    cd $d
	      mvn clean install -DskipTests=true -Dmaven.repo.local=$M2REPO
	      mvn versions:set -DnewVersion=0.0.0-SNAPSHOT -DallowSnapshots -Dmaven.repo.local=$M2REPO
	    cd ..
	done
rm -rf $M2REPO/am/ik/blog
cd ..

cd m2
	tar -C rootfs -cf rootfs.tar .
	mv rootfs.tar ../to-push
cd ..
