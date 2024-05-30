# About 

```
This repo is about hadoop with kerberos authentication for both hadoop client and hadoop services.

The user authenticates using the principal and password stored in the kerberos databse and obatains the kerberos ticket granting ticket from the Authentication Server.

The tgt obtained in previous step is used by the client to obtain the hadoop service ticket from the ticket granting Server.

After obtaining the Service ticket user is allowed to perform the permitted operations on hadoop.
```

# Requirements

```
Hadoop-3.3.6,
Docker,
Kerberos(krb5-user).
```

# Configuration


* Add the following configuration for hadoop client hdfs-site.xml and core-site.xml 

* path to file : hadoop-3.3.6/etc/hadoop/ vi hdfs-site.xml

```
<property>
        <name>dfs.replication</name>
        <value>1</value>
</property>
<property>
        <name>dfs.data.transfer.protection</name>
        <value>integrity</value>
</property>
```

* path to file : hadoop-3.3.6/etc/hadoop/ vi core-site.xml

```
<property>
        <name>hadoop.security.authentication</name>
        <value>kerberos</value>
</property>
<property>
        <name>hadoop.rpc.protection</name>
        <value>authentication</value>
</property>
```

* Configure the kerberos client krb5.conf with following configs

* path to file : /etc/krb5.conf

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

# Run the following hdfs client commands
```
* mkdir : creates the directory in the root.

   hdfs dfs -mkdir hdfs://localhost:8020/

* list : lists all the directories and files in the hdfs filesystem.

   hdfs dfs -ls hdfs://localhost:8020/

* copyFromLocal : copy the file from local system to hdfs directory.

   hdfs dfs -copyFromLocal <local system  file path (src )>  <hdfs file path (dest)>

* cat : To print the file contents.

    hdfs dfs -cat hdfs://localhost:8020/<path to file>
```


