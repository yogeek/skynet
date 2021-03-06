echo "Starting up skynet  ######################"
docker network create --opt encrypted --driver overlay multihostnetwork
docker service create --name skynet-registry --network multihostnetwork --publish 5000:5000 --mode global registry:2.6.2
docker pull dockersamples/visualizer:latest
docker tag dockersamples/visualizer:latest localhost:5000/visualizer:latest
docker push localhost:5000/visualizer:latest
docker pull laurentgrangeau/skynet-terminator:latest
docker tag laurentgrangeau/skynet-terminator:latest localhost:5000/skynet-terminator:latest
docker push localhost:5000/skynet-terminator:latest
docker service create --name skynet-visualizer --network multihostnetwork --publish 8080:8080 --constraint node.role==manager --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock localhost:5000/visualizer:latest
#docker service create --name skynet-terminator --network multihostnetwork --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock localhost:5000/skynet-terminator:latest
