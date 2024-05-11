#! /bin/bash

/usr/sbin/kdb5_util -P changeme create -s


## password only user
/usr/sbin/kadmin.local -q "addprinc  -randkey sagar"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/sagar.keytab sagar"

#/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/server.example.com"
#/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/server.keytab HTTP/server.example.com"

/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/namenode"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/namenode"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/datanode"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/datanode"

/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/resourcemanager"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/resourcemanager"

/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/nodemanager"
/usr/sbin/kadmin.local -q "addprinc -randkey HTTP/nodemanager"


/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/namenode"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/namenode"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/datanode"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/datanode"

/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/resourcemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/resourcemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/nodemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab HTTP/nodemanager"



chown hdfs /var/keytabs/hdfs.keytab


keytool -genkey -alias nodename -keyalg rsa -keysize 1024 -dname "CN=namenode" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
keytool -genkey -alias datanode -keyalg rsa -keysize 1024 -dname "CN=datanode" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme

chmod 700 /var/keytabs/hdfs.jks
chown hdfs /var/keytabs/hdfs.jks


krb5kdc -n