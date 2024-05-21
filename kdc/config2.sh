#! /env/sh

# Deafult values
REALM_NAME="${REALM_NAME-EXAMPLE.COM}"
DOMAIN_NAME="${DOMAIN_NAME-example.com}"
KADMIN_PASS="${KADMIN_PASS-root}"
MASTER_PASS="${MASTER_PASS-Master_Password}"

# Copying krb5 conf file
cat > /etc/krb5.conf << EOL
[logging]
    default = FILE:/var/log/krb5libs.log
    kdc = FILE:/var/log/krb5kdc.log
    admin_server = FILE:/var/log/kadmind.log

[libdefaults]
    dns_lookup_realm = true
    ticket_lifetime = 24h
    renew_lifetime = 7d
    forwardable = true
    rdns = false
    default_realm = ${REALM_NAME}

[realms]
    ${REALM_NAME} = {
        kdc = kdc
        admin_server = kdc
    }

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

# Start services
#kadmind 
#krb5kdc

#tail -f /var/log/krb5kdc.log

#! /bin/bash

/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/namenode"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/datanode"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/resourcemanager"
/usr/sbin/kadmin.local -q "addprinc -randkey hdfs/nodemanager"
/usr/sbin/kadmin.local -q "addprinc -randkey yarn/resourcemanager"
/usr/sbin/kadmin.local -q "addprinc -randkey yarn/nodemanager"
/usr/sbin/kadmin.local -q "addprinc -randkey hadoop"

/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/namenode"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/datanode"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/resourcemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hdfs/nodemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab yarn/nodemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab yarn/resourcemanager"
/usr/sbin/kadmin.local -q "ktadd -k /var/keytabs/hdfs.keytab hadoop"

kadmin.local -q "addprinc -pw hdfs hdfs"
kadmin.local -q "addprinc -pw sagar sagar"

chmod 777 /var/keytabs/hdfs.keytab


krb5kdc -n
tail -f /var/log/krb5kdc.log
