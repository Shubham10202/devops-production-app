#!/bin/bash

URL="http://localhost:8080/health"

if curl -sf "$URL" > /dev/null
then
    echo "HEALTHY: Application is responding"
    exit 0
else
    echo "UNHEALTHY: Application is not responding"
    exit 1
fi
