#! /bin/bash
 
echo "Removing exited docker containers..."
docker rm -v $(docker ps -a -f status=exited -q)
 
echo "Removing untagged images..."
docker rmi $(docker images --no-trunc | grep "<none>" | awk '{print $3}')
 
echo "Removing unused docker images"
images=($(docker images | awk '{print $1":"$2}'))
containers=($(docker ps -a | awk '{print $2}'))
 
containers_reg=" ${containers[*]} "
remove=()
 
for item in ${images[@]}; do
  if [[ ! $containers_reg =~ " $item " ]]; then
    remove+=($item)
  fi
done
 
remove_images=" ${remove[*]} "
 
docker rmi ${remove_images}
echo "Done"
