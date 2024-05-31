# About 


This repo is about hadoop with kerberos authentication for both hadoop client and hadoop services.\
The user authenticates using the principal and password stored in the kerberos database and obtains the kerberos ticket granting ticket from the Authentication Server.\
The tgt obtained in previous step is used by the client to obtain the hadoop service ticket from the ticket granting Server.\
After obtaining the Service ticket user is allowed to perform the permitted operations on hdfs.

# Requirements


1.install `java 11.0` suitable for your operating system from below link and setup the java environment variables.

 * https://www.openlogic.com/openjdk-downloads?page=2 

2.install hadoop-3.3.6 for the client system using below given link.


 * https://hadoop.apache.org/releases.html

 

3.install Kerberos(krb5-user) for client system using below given link.

 * https://kerberos.org/dist/


4.Docker.

# Configuration


Add the following configuration for hadoop client `hdfs-site.xml` and `core-site.xml` 


path to hdfs-site.xml:
 * ubuntu/windows(wsl2):`/hadoop-3.3.6/etc/hadoop/`
 * mac os:`/opt/homebrew/Cellar/hadoop/3.3.6/libexec/etc/hadoop`

```
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

path to core-site.xml:
 * ubuntu/windows(wsl2):`/hadoop-3.3.6/etc/hadoop/`
 * mac os:`/opt/homebrew/Cellar/hadoop/3.3.6/libexec/etc/hadoop`

```
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

Configure the kerberos client `krb5.conf` with following configs

path to krb5.conf:
 * ubuntu/windows(wsl2):`/etc/krb5.conf`
 * mac os:` /Library/Preferences/edu.mit.kerberos`


```
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
  docker compose up --build -d
```

# Run the following hdfs commands in client system

* use hdfs principal to obtain the kerberos ticket.
* password : hdfs
```
  kinit hdfs@EXAMPLE.COM
```
* `mkdir` : Creates the directory in the root.
```
   hdfs dfs -mkdir hdfs://localhost:8020/<directory name>
```
* `list` : Lists all the directories and files in the hdfs filesystem.
```
   hdfs dfs -ls hdfs://localhost:8020/<path>
```
* `copyFromLocal` : Copy the file from local system to hdfs filesystem.
```
   hdfs dfs -copyFromLocal <local system file path (src)>  <hdfs file path (dest)>
```
* `cat` : To print the file contents.
```
    hdfs dfs -cat hdfs://localhost:8020/<path to file>
```
* hdfs commands :

    https://www.geeksforgeeks.org/hdfs-commands/



