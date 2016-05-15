FROM bprodoehl/android-dev

MAINTAINER Joey Vos

RUN wget https://downloads.gradle.org/distributions/gradle-2.13-bin.zip
RUN unzip gradle-2.13-bin.zip
RUN mv gradle-2.13 /usr/local/gradle
RUN rm gradle-2.13-bin.zip
