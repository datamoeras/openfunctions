#!/bin/bash
set -e
cd $(dirname $0)

intag=latest
app=app
tag="$id"
echo "use tag $tag"

reg=$REGISTRY
prefix=open

if [[ $1 == '-p' ]]; then
	echo "enable pull";
	pull=-p
	shift;
fi
if [[ $1 == '-b' ]]; then
	echo "enable build";
	build=-b
	shift;
fi

if [[ $1 == '-P' ]]; then
  shift;
	echo "enable push";
	push="$1"
  andpush="-P $push"
	shift;
fi

if [[ $1 == '-t' ]]; then
  shift;
	echo "enable trigger";
	trigger="$1"
	shift;
fi

if [[ -n $pull ]]; then
	cd "$app"; git pull; cd -
fi

if [[ -z $id ]]; then
  echo "no id";
  exit 1;
fi

if [[ -n $build ]]; then
  docker pull mcr.microsoft.com/azure-functions/node:4-node20-appservice
  # docker build --network=host --tag ${prefix}funcbase:$tag -f Dockerfile.funcbase source
  docker build --network=host --build-arg TAG=$tag --tag ${prefix}funccustom:$tag -f Dockerfile.funccustom source
  docker build --network=host --build-arg TAG=$tag --tag ${prefix}func:$tag -f Dockerfile.functions "$app"
fi

if [[ -n $push ]]; then
  docker tag ${prefix}funcbase:$tag $reg/${prefix}funcbase:$push
  docker tag ${prefix}funccustom:$tag $reg/${prefix}funccustom:$push
  docker tag ${prefix}func:$tag $reg/${prefix}func:$push
  docker push $reg/${prefix}func:$push
fi

if [[ -n $trigger ]]; then
  curl -d '{}' "$trigger"
fi
