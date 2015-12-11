#!/bin/bash

/opt/ice/grailsw \
	-Djava.net.preferIPv4Stack=true \
	-Djava.net.preferIPv4Addresses \
	-Dice.s3AccessKeyId=$S3_ACCESS_KEY_ID \
	-Dice.s3SecretKey=$S3_SECREAT_KEY_ID \
	run-app
  
