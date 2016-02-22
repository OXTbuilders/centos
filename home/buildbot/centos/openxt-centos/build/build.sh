#!/bin/bash

BUILDID=$1
BRANCH=$2

rm -rf openxt
git clone -b $BRANCH https://github.com/OpenXT/openxt.git
cd openxt
mkdir src
cd src
git clone -b $BRANCH https://github.com/OpenXT/sync-database.git
git clone -b $BRANCH https://github.com/OpenXT/sync-cli.git
git clone -b $BRANCH https://github.com/OpenXT/sync-server.git
git clone -b $BRANCH https://github.com/OpenXT/sync-ui-helper.git
cd -
#. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/u01/app/oracle/product/11.2.0/xe/lib
./do_sync_xt.sh /home/buildbot/centos/openxt-centos/build/openxt
rsync -a out/*.rpm builds@192.168.0.10:/home/builds/builds/${BRANCH}/syncxt/${BUILDID}/
