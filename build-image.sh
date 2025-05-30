#!/bin/bash
docker build --build-arg SECRET_KEY_BASE=$SECRET_KEY_BASE -t hectorjacales/plats-bokning .
docker push hectorjacales/plats-bokning
