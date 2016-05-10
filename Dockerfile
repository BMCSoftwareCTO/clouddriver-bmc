FROM java:8

MAINTAINER delivery-engineering@netflix.com

COPY . workdir/

WORKDIR workdir

RUN GRADLE_USER_HOME=cache ./gradlew buildDeb -x test

RUN dpkg -i ./clouddriver-web/build/distributions/spinnaker-clouddriver_*.deb


COPY bmc/ workdir/bmc/

WORKDIR workdir/bmc

RUN GRADLE_USER_HOME=cache ./gradlew buildDeb -x test

RUN dpkg -i ./clouddriver-web/build/distributions/spinnaker-clouddriver-bmc*.deb


CMD ["/opt/clouddriver/bin/clouddriver"]
