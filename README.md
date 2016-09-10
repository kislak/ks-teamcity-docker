TIPS

.env.example => .env

docker-compose up

# sh in container

docker exec -it teamcity_server sh

find . -name "teamcity-server.log"


# Delete all containers

docker rm $(docker ps -a -q)

# Delete all images

docker rmi $(docker images -q)
