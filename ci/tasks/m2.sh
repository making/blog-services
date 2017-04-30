#/bin/sh

BASEDIR=`pwd`
M2REPO=${BASEDIR}/m2/rootfs/opt/m2

DIR="$DIR blog-domain"
DIR="$DIR blog-mapper"
DIR="$DIR blog-api"
DIR="$DIR blog-kotlin-ui"
DIR="$DIR feed"



if [ "$1" == "init" ]; then
	mkdir -p $M2REPO
fi

cd repo
ls -la
	for d in $DIR;do
		${BASEDIR}/utils/scripts/add-repos-in-pom-xml.sh ${d}
	    echo "++++ Build $d ++++"
	    cd $d
	      ./mvnw clean install -DskipTests=true -Dmaven.repo.local=$M2REPO
	      ./mvnw versions:set -DnewVersion=0.0.0-SNAPSHOT -DallowSnapshots -Dmaven.repo.local=$M2REPO
	    cd ..
	done
rm -rf $M2REPO/am/ik/blog
cd ..

cd m2
	tar -C rootfs -cf rootfs.tar .
	mv rootfs.tar ../to-push
cd ..
