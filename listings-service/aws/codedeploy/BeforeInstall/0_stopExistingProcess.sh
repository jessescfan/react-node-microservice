#!/bin/sh

deployment_dir=/opt/microservice/listings-service
if [ -d "$deployment_dir" ] && [ -x "$deployment_dir" ]; then
  cd $deployment_dir

  # we have to do this because it throws an error if it can't find the process... and then the whole build breaks
  pm2 stop listings-service || true
fi