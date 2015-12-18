FROM beevelop/java
MAINTAINER Maik Hummel <m@ikhummel.com>

# Build-Variables
ENV ANDROID_SDK_FILE="android-sdk_r24.4.1-linux.tgz" \
    ANDROID_SDK_URL="https://dl.google.com/android/${ANDROID_SDK_FILE}" \
    ANDROID_BUILD_TOOLS_VERSION=23.0.2 \
    ANDROID_APIS="android-10,android-15,android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23"

# Set Environment Variables
ENV ANT_HOME="/usr/share/ant" \
    MAVEN_HOME="/usr/share/maven" \
    GRADLE_HOME="/usr/share/gradle" \
    ANDROID_HOME="/opt/android-sdk-linux"

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/$ANDROID_BUILD_TOOLS_VERSION
ENV PATH $PATH:$ANT_HOME/bin
ENV PATH $PATH:$MAVEN_HOME/bin
ENV PATH $PATH:$GRADLE_HOME/bin

WORKDIR "/opt"

RUN dpkg --add-architecture i386 && \
    apt-get -qq update & \
    apt-get -qq install -y curl ant gradle libncurses5:i386 libstdc++6:i386 zlib1g:i386 && \

    # Installs Android SDK
    curl -sL ${ANDROID_SDK_URL} | tar xz -C . && \
    echo y | android update sdk -a -u -t platform-tools,${ANDROID_APIS},build-tools-${ANDROID_BUILD_TOOLS_VERSION} && \
    chmod a+x -R $ANDROID_HOME && \

    # Clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean
