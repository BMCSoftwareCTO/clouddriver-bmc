FROM java:8

MAINTAINER delivery-engineering@netflix.com

COPY . workdir/

WORKDIR workdir

RUN GRADLE_USER_HOME=cache ./gradlew buildDeb -x test

RUN dpkg -i ./clouddriver-web/build/distributions/*.deb


#COPY bmc/ workdir/bmc/

# change WORKDIR to workdir/bmc. It is relative to the current WORKDIR
WORKDIR bmc

RUN GRADLE_USER_HOME=cache ./gradlew buildDeb -x test

RUN dpkg -i ./clouddriver-web/build/distributions/*.deb


CMD ["/opt/clouddriver/bin/clouddriver"]
