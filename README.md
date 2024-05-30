# About 

```
This repo is about hadoop with kerberos authentication for both hadoop client and hadoop services.

The user authenticates using the principal and password stored in the kerberos database and obtains the kerberos ticket granting ticket from the Authentication Server.

The tgt obtained in previous step is used by the client to obtain the hadoop service ticket from the ticket granting Server.

After obtaining the Service ticket user is allowed to perform the permitted operations on hdfs.
```

# Requirements


1.install hadoop for the client system

  * use compressed archive file to install `hadoop-3.3.6`.
```
    https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6-src.tar.gz
```
  * decompress the hadoop-3.3.6 file using the following command in the terminal 
```   
    tar -xzf hadoop-3.3.6.tar.gz
``` 
  * setup Environment Variables for hadoop.
```
    export HADOOP_HOME=/path/to/hadoop-3.3.6
    export PATH=$PATH:$HADOOP_HOME/bin
```
  * check hadoop version
```
    hadoop version
```

2.install Kerberos(krb5-user) for client system

  * use the following command

```
    apt install krb5-user
```

3.install `java 11.0`.
  
  * use the follwing command

```
    apt install openjdk-11-jdk
```

  * setup environment variable for java

```
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64  
    export PATH=$PATH:$JAVA_HOME/bin

```
  * check java version

```
    javac -version
```

4.Docker.

# Configuration


* Add the following configuration for hadoop client `hdfs-site.xml` and `core-site.xml` 

```
 path to hdfs-site.xml:/hadoop-3.3.6/etc/hadoop/ vi hdfs-site.xml

<configuration>
<property>
        <name>dfs.replication</name>
        <value>1</value>
</property>
<property>
        <name>dfs.data.transfer.protection</name>
        <value>integrity</value>
</property>
</configuration>
```

```
 path to core-site.xml:/hadoop-3.3.6/etc/hadoop/ vi core-site.xml

<configuration>
<property>
        <name>hadoop.security.authentication</name>
        <value>kerberos</value>
</property>
<property>
        <name>hadoop.rpc.protection</name>
        <value>authentication</value>
</property>
</configuration>
```

* Configure the kerberos client `krb5.conf` with following configs

```
path to krb5.conf:/etc/krb5.conf

[realms]

EXAMPLE.COM = {
		kdc = localhost:8081
		admin_server = localhost:8082
		}
[domain_realm]

 .example.com = EXAMPLE.COM
  example.com = EXAMPLE.COM
```
# Run Docker compose command to start hadoop and kerberos services in the docker container

```
  docker compose up
```

# Run the following hdfs commands in client system

* use hdfs principal to obtain the kerberos ticket.
```
  kinit hdfs@EXAMPLE.COM.
  password : hdfs.
```
* `mkdir` : Creates the directory in the root.
```
   hdfs dfs -mkdir hdfs://localhost:8020/
```
* `list` : Lists all the directories and files in the hdfs filesystem.
```
   hdfs dfs -ls hdfs://localhost:8020/
```
* `copyFromLocal` : Copy the file from local system to hdfs filesystem.
```
   hdfs dfs -copyFromLocal <local system  file path (src)>  <hdfs file path (dest)>
```
* `cat` : To print the file contents.
```
    hdfs dfs -cat hdfs://localhost:8020/<path to file>
```
* hdfs commands :
```
    https://www.geeksforgeeks.org/hdfs-commands/
```


