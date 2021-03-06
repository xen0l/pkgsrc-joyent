$NetBSD$

--- bin/hcat_server.sh.orig	2013-01-30 21:31:35.000000000 +0000
+++ bin/hcat_server.sh
@@ -21,7 +21,7 @@ bin=`which $0`
 bin=`dirname ${bin}`
 bin=`cd "$bin"; pwd`
 
-HCAT_LOG_DIR=${HCAT_LOG_DIR:-"$bin"/../var/log}
+HCAT_LOG_DIR=${HCAT_LOG_DIR:-@HCAT_LOG_DIR@}
 HCAT_PID_DIR=${HCAT_PID_DIR:-$HCAT_LOG_DIR}
 
 if [ -e "$bin/../libexec/hcat-config.sh" ]; then
@@ -49,7 +49,7 @@ function start_hcat() {
     exit 1
   fi
 
-  HIVE_SITE_XML=${HIVE_HOME}/conf/hive-site.xml
+  HIVE_SITE_XML=@PKG_SYSCONFBASE@/hive/hive-site.xml
   if [ ! -e $HIVE_SITE_XML ]
   then
     echo "Missing hive-site.xml, expected at [$HIVE_SITE_XML]";
@@ -88,7 +88,7 @@ function start_hcat() {
   export HADOOP_OPTS="${HADOOP_OPTS} -server -XX:+UseConcMarkSweepGC -XX:ErrorFile=${HCAT_LOG_DIR}/hcat_err_pid%p.log -Xloggc:${HCAT_LOG_DIR}/hcat_gc.log-`date +'%Y%m%d%H%M'` -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps"
   export HADOOP_HEAPSIZE=2048 # 8G is better if you have it
   export METASTORE_PORT=${METASTORE_PORT}
-  nohup ${HIVE_HOME}/bin/hive --service metastore >${HCAT_LOG_DIR}/hcat.out 2>${HCAT_LOG_DIR}/hcat.err &
+  nohup @PREFIX@/bin/hive --service metastore >${HCAT_LOG_DIR}/hcat.out 2>${HCAT_LOG_DIR}/hcat.err &
 
   PID=$!
 
