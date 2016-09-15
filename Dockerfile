# Android development environment based on Ubuntu 14.04 LTS.
# version 0.0.13

# Start with Ubuntu 14.04 LTS.
FROM phusion/baseimage

# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

# First, install add-apt-repository and bzip2
RUN apt-get update
RUN apt-get -y install software-properties-common python-software-properties bzip2 unzip openssh-client git lib32stdc++6 lib32z1 expect

# Add oracle-jdk8 to repositories
RUN add-apt-repository ppa:webupd8team/java

# Update apt
RUN apt-get update

# Install oracle-jdk8
RUN apt-get -y install oracle-java8-installer

# Install android sdk
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar -xvzf android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk
RUN rm android-sdk_r24.4.1-linux.tgz

# Install Android tools
# doesn't work with yes | command or echo "y" | command, it goes to quick, or runs only once, respectively
RUN (sleep 5 && while [ 1 ]; do sleep 5; echo y; done ) | /usr/local/android-sdk/tools/android update sdk --force --no-ui --all --filter android-24,android-23,android-22,tool,platform-tool,extra,addon-google_apis-google-19,addon-google_apis_x86-google-19,build-tools-25.2.2,build-tools-24.0.3,build-tools-24.0.2,build-tools-24.0.1,build-tools-23.0.3,build-tools-23.0.2,build-tools-23.0.1,build-tools-23.0.0,build-tools-22.0.1,build-tools-22.0.0,build-tools-21.1.2,build-tools-21.1.1,build-tools-21.1.0,build-tools-21.0.2,build-tools-21.0.1,build-tools-21.0.0,build-tools-20.0.0,build-tools-19.1.0,build-tools-19.0.3,build-tools-19.0.2,build-tools-19.0.1,build-tools-19.0.0,build-tools-18.1.1,build-tools-18.1.0,build-tools-18.0.1,build-tools-17.0.0

# Install Android NDK
RUN wget https://dl.google.com/android/ndk/android-ndk-r9d-linux-x86_64.tar.bz2
RUN tar -xvjf android-ndk-r9d-linux-x86_64.tar.bz2
RUN mv android-ndk-r9d /usr/local/android-ndk
RUN rm android-ndk-r9d-linux-x86_64.tar.bz2

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-2.13-bin.zip
RUN unzip gradle-2.13-bin.zip
RUN mv gradle-2.13 /usr/local/gradle
RUN rm gradle-2.13-bin.zip

# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV ANDROID_NDK_HOME /usr/local/android-ndk
ENV GRADLE_HOME /usr/local/gradle
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$ANDROID_NDK_HOME
ENV PATH $PATH:$GRADLE_HOME/bin

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
