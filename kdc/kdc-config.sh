#! /env/sh

# Deafult values
REALM_NAME="${REALM_NAME-EXAMPLE.COM}"
DOMAIN_NAME="${DOMAIN_NAME-example.com}"
KADMIN_PASS="${KADMIN_PASS-root}"
MASTER_PASS="${MASTER_PASS-Master_Password}"

# Copying krb5 conf file
cat > /etc/krb5.conf << EOL

[libdefaults]
    default_realm = ${REALM_NAME}

[domain_realm]
    .${DOMAIN_NAME} = ${REALM_NAME}
    ${DOMAIN_NAME} = ${REALM_NAME}
EOL

# Creating initial database
kdb5_util -r ${REALM_NAME} create -s << EOL
${MASTER_PASS}
${MASTER_PASS}
EOL

# Creating admin principal
kadmin.local -q "addprinc root/admin@${REALM_NAME}" << EOL
${KADMIN_PASS}
${KADMIN_PASS}
EOL

#! /bin/ash


rm /var/keytabs/hdfs.keytab

kadmin.local -q "addprinc -randkey hdfs/namenode"
kadmin.local -q "addprinc -randkey hdfs/datanode"
kadmin.local -q "addprinc -randkey hdfs/resourcemanager"
kadmin.local -q "addprinc -randkey hdfs/nodemanager"
kadmin.local -q "addprinc -randkey yarn/resourcemanager"
kadmin.local -q "addprinc -randkey yarn/nodemanager"
kadmin.local -q "addprinc -randkey hadoop"

kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/namenode"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/datanode"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/resourcemanager"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/nodemanager"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab yarn/nodemanager"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab yarn/resourcemanager"
kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hadoop"

kadmin.local -q "addprinc -pw hdfs hdfs"
kadmin.local -q "addprinc -pw sagar sagar"

chmod 777 /var/keytabs/hdfs.keytab


keytool -genkey -alias namenode -keyalg rsa -keysize 1024 -dname "CN=namenode" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme
keytool -genkey -alias datanode -keyalg rsa -keysize 1024 -dname "CN=datanode" -keypass changeme -keystore /var/keytabs/hdfs.jks -storepass changeme

chmod 777 /var/keytabs/hdfs.jks

krb5kdc -n


