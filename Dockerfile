FROM beevelop/java

MAINTAINER Maik Hummel <m@ikhummel.com>

ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/tools_r25.2.5-linux.zip" \
    ANDROID_BUILD_TOOLS_VERSION=25.0.3 \
    ANDROID_APIS="android-10,android-15,android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23,android-24,android-25" \
    ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-3.4.1-bin.zip" \
    GRADLE_HOME="/opt/gradle/gradle-3.4.1" \
    ANDROID_HOME="/opt/android"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION:$ANT_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin

WORKDIR /opt

RUN dpkg --add-architecture i386 && \
    apt-get -qq update && \
    apt-get -qq install -y wget curl maven ant libncurses5:i386 libstdc++6:i386 zlib1g:i386 unzip && \
    
    # Installs Gradle 3.4.1
    wget -O gradle.zip ${GRADLE_URL} && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle.zip && rm gradle.zip && \

    # Installs Android SDK
    mkdir android && cd android && \
    wget -O tools.zip ${ANDROID_SDK_URL} && \
    unzip tools.zip && rm tools.zip && \
    echo y | android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
    chmod a+x -R $ANDROID_HOME && \
    chown -R root:root $ANDROID_HOME && \

    # Clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean
