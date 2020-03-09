#!/bin/sh

deployment_dir=/opt/microservice/api-gateway
if [ -d "$deployment_dir" ] && [ -x "$deployment_dir" ]; then
  cd $deployment_dir

  rm -rf *
fi