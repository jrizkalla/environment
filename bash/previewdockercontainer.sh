container=$(echo $1 | awk '{print $1}')
docker container ls --filter id="$container"
