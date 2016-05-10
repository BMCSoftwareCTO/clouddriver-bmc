FROM java:8

MAINTAINER delivery-engineering@netflix.com

COPY . workdir/

WORKDIR workdir

RUN GRADLE_USER_HOME=cache ./gradlew buildDeb -x test

RUN dpkg -i ./clouddriver-web/build/distributions/*.deb


COPY bmc/ workdir/bmc/

WORKDIR workdir/bmc

RUN GRADLE_USER_HOME=cache ./gradlew buildDeb -x test

RUN dpkg -i ./clouddriver-web/build/distributions/*.deb


CMD ["/opt/clouddriver/bin/clouddriver"]
