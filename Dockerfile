FROM ubuntu:20.04

LABEL maintainer="Majroch <jakuboch4@gmail.com>"
LABEL description="Containerized environment for Jetbrains Toolbox app"

# Specify CPU architecture
ARG ARCH="x86_64"
ARG VERSION="2.3.0.30876"

# Disable interactive prompts from packages
ARG DEBIAN_FRONTEND=noninteractive

# User configuration
ENV UID="1000"
ENV GID="1000"

# Update repository
RUN apt-get update

# Install required packages to run / install toolbox app
RUN apt-get install -y \
      wget \
      git \
      fuse \
      libfuse2 \
      libxi6 \
      libxrender1 \
      mesa-utils \
      libfontconfig \
      libgtk-3-bin \
      tar \
      dbus-user-session \
      gpg \
      xdg-utils \
    && rm -rf /var/lib/apt/lists/* \
    && apt clean

RUN if [[ "${ARCH}" == "arm64" ]]; then archSuffix='-arm64'; fi

RUN fileName="jetbrains-toolbox-${VERSION}${archSuffix}" \
    && url="https://download.jetbrains.com/toolbox/${fileName}.tar.gz" \
    && wget "${url}" -O "/tmp/jetbrains-toolbox.tar.gz" \
    && tar -xaf "/tmp/jetbrains-toolbox.tar.gz" -C "/tmp" \
    && mv "/tmp/${fileName}/jetbrains-toolbox" "/usr/local/bin" \
    && chmod 755 "/usr/local/bin/jetbrains-toolbox"

# Prepare rootless user
RUN groupadd \
    user \
    -g "${GID}"
    
RUN useradd \
    user \
    -d /home/user \
    -u "${UID}" \
    -g "${GID}" \
    -m

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod 755 /entrypoint.sh

USER user
WORKDIR /home/user/Projects

CMD ["/entrypoint.sh"]

