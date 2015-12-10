FROM jonbrouse/java:7

ENV INSTALL_DIR /opt/ice
ENV HOME_DIR /root
ENV GRAILS_VERSION 2.4.4
ENV GRAILS_HOME ${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}
ENV PATH $PATH:${HOME_DIR}/.grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}/bin/

WORKDIR ${HOME_DIR}

# Install required software
RUN \
  apt-get update && \
  apt-get install -y unzip && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p ${INSTALL_DIR} && \
  mkdir -p .grails/wrapper/${GRAILS_VERSION} && \
  curl -o .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/grails-${GRAILS_VERSION}.zip && \
  unzip .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip -d .grails/wrapper/${GRAILS_VERSION} && \
  rm -rf .grails/wrapper/${GRAILS_VERSION}/grails-${GRAILS_VERSION}.zip

WORKDIR ${INSTALL_DIR}

EXPOSE 8080
CMD ["/opt/ice/grailsw"]

# Ice setup
RUN mkdir /mnt/ice_processor && mkdir /mnt/ice_reader
COPY . ${INSTALL_DIR}

RUN grails ${JAVA_OPTS} wrapper && \
  rm grails-app/i18n/messages.properties && \ 
  sed -i -e '1i#!/bin/bash\' grailsw
