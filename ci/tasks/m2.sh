#/bin/sh

BASEDIR=`pwd`
M2REPO=${BASEDIR}/m2/rootfs/opt/m2

# DIR="$DIR eureka-server"
DIR="$DIR blog-api"
DIR="$DIR blog-kotlin-ui"
DIR="$DIR feed"
#DIR="$DIR hystrix-dashboard"


if [ "$1" == "init" ]; then
	mkdir -p $M2REPO
fi

cd repo
ls -la
	for d in $DIR;do
		${BASEDIR}/utils/scripts/add-repos-in-pom-xml.sh ${d}
	    echo "++++ Build $d ++++"
	    cd $d
	        artifactId=`./mvnw help:evaluate -Dexpression=project.artifactId -Dmaven.repo.local=$M2REPO | egrep -v '(^\[INFO])'`
		echo $artifactId
	        ./mvnw clean package -Dmaven.repo.local=$M2REPO
	    cd ..
	done
cd ..

cd m2
	tar -C rootfs -cf rootfs.tar .
	mv rootfs.tar ../to-push
cd ..
