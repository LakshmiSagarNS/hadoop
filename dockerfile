FROM centos:7
RUN yum -y install krb5-server krb5-workstation krb5-libs krb5-auth
RUN yum -y install java-1.8.0-openjdk-headless
RUN yum -y install apache-commons-daemon-jsvc
RUN yum install net-tools -y
RUN yum install telnet telnet-server -y
RUN yum -y install which
RUN sed -i -e 's/#//' -e 's/default_ccache_name/# default_ccache_name/' /etc/krb5.conf
RUN useradd -u 1098 hdfs
COPY start-kdc.sh /tmp
RUN chmod 777 /tmp/start-kdc.sh
ENV JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
