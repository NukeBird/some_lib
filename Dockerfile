FROM alpine

LABEL maintainer="NukeBird"

ENV NDK_VERSION="android-ndk-r18b"
ENV LANG="C.UTF-8"
ENV GLIBC_VERSION "2.28-r0"

RUN apk update && \ 
	apk upgrade

RUN apk add --no-cache nano file bash dpkg git autoconf automake make cmake clang clang-dev gcc g++ lld musl-dev && \
	wget https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub && \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -O /tmp/glibc.apk && \
	wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -O /tmp/glibc-bin.apk && \
	apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk && \
	rm -rf /tmp/* && \
	rm -rf /var/cache/apk/*

# Download and unzip the Android NDK
RUN wget -O /${NDK_VERSION}.zip https://dl.google.com/android/repository/${NDK_VERSION}-linux-x86_64.zip && \
	unzip /${NDK_VERSION}.zip && \
	rm /${NDK_VERSION}.zip

# Add ndk-build to the search path
ENV PATH="/${NDK_VERSION}/:${PATH}"
ENV ANDROID_NDK_r18b="/${NDK_VERSION}/"

RUN git clone --depth=1 https://github.com/cpp-pm/polly polly

ENV POLLY_ROOT="/polly/"
ENV PATH="${POLLY_ROOT}:${PATH}"