
# lighttpd-centos7
FROM openshift/base-centos7

MAINTAINER Harish Shetty <harish.kb27@gmail.com>

ENV LIGHTTPD_VERSION=1.4.35

LABEL io.k8s.description="Platform for serving static HTML files" \
     io.k8s.display-name="lighttpd 1.4.35" \
     io.openshift.expose-services="8080:http" \
     io.openshift.tags="builder,html,lighttpd,1.4.35"

RUN cd /tmp/ && wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm && \
	yum install -y epel-release-7-8.noarch.rpm && rm -f epel-* && cd - && \
	yum install -y lighttpd && \
	yum clean all -y

LABEL io.openshift.s2i.scripts-url=image:///usr/libexec/s2i

COPY ./.s2i/bin/ /usr/libexec/s2i

# Copy the lighttpd configuration file
COPY ./etc/ /opt/app-root/etc

RUN chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

CMD ["usage"]
