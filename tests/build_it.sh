#!/bin/bash
docker build -t signmeup/meteord:base ../base
docker build -t signmeup/meteord:onbuild ../onbuild
docker build -t signmeup/meteord:devbuild ../devbuild
# docker build -t signmeup/meteord:binbuild ../binbuild
docker build -t signmeup/meteord:volbuild ../volbuild
