#!/bin/sh

deployment_dir=/opt/microservice/listings-service
if [ -d "$deployment_dir" ] && [ -x "$deployment_dir" ]; then
  cd $deployment_dir

  rm -rf *
fi