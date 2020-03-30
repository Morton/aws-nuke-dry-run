#!/bin/bash

docker run --rm -it -v $(pwd)/nuke-config.yml:/home/aws-nuke/config.yml quay.io/rebuy/aws-nuke:v2.11.0 --config /home/aws-nuke/config.yml --access-key-id $AWS_ACCESS_KEY_ID --secret-access-key $AWS_SECRET_ACCESS_KEY $@
