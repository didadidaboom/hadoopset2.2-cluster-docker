#!/bin/bash

# the default node number is 3
N=${1:-3}


# start mysql container
sudo docker rm -f hadoop-mysql &> /dev/null
echo "start hadoop-mysql container..."
sudo docker run -itd \
                --net=hadoop \
                --name hadoop-mysql \
                --hostname hadoop-mysql \
		-e MYSQL_ROOT_PASSWORD=hive \
                mysql &> /dev/null

# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop \
		-p 8022:22 \
		-p 16010:16010 \
                -p 50070:50070 \
                -p 8088:8088 \
		-p 8888:8888 \
		-p 8080:8080 \
                --name hadoop-master \
                --hostname hadoop-master \
                didadidaboom/hadoopset:2.2 &> /dev/null


# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave$i &> /dev/null
	echo "start hadoop-slave$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name hadoop-slave$i \
	                --hostname hadoop-slave$i \
	                didadidaboom/hadoopset:2.2 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it hadoop-master bash
