#!/bin/bash
if [ ! $# -eq 1 ]
then
	echo "Sorry, you must provide the name of the container"
	exit -1
fi


until [ "`/usr/bin/docker inspect -f {{.State.Running}} $1`" == "true" ]
do
	sleep 0.1
done
echo "Attaching to container..."
docker attach $1
