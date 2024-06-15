FROM ubuntu:latest
RUN apt-get update && apt-get install -y x11vnc xvfb wget bzip2 libgtk-3-0 libasound2-data libc6 libpci-dev libegl-dev
RUN apt-get install -y qtdeclarative5-dev xz-utils software-properties-common libgl1-mesa-dri mesa-utils xterm xkb-data gimp

RUN wget -O /tmp/mesa.tar.xz "https://archive.mesa3d.org/mesa-23.0.0-rc4.tar.xz" \
    && tar -xf /tmp/mesa.tar.xz -C /opt/


ENV LIBGL_ALWAYS_SOFTWARE=true
ENV MESA_LOADER_DRIVER_OVERRIDE=llvmpipe
# Symlink Mesa binaries
RUN ln -s /opt/mesa-23.0.0-rc4/bin/mesa /usr/local/bin/mesa
ENV XDG_RUNTIME_DIR=/run/user/dockerp

RUN mkdir $XDG_RUNTIME_DIR && chmod 777 $XDG_RUNTIME_DIR

ENV DISPLAY=:93
COPY . /app

RUN wget -O /tmp/code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" \
   && apt install /tmp/code.deb \
    && apt-get install wget gpg \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \
    && echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |tee /etc/apt/sources.list.d/vscode.list > /dev/null \
&& rm -f packages.microsoft.gpg \
&& apt install apt-transport-https \
&& apt update \
&& apt install code
EXPOSE 5900
USER $USERNAME
ENTRYPOINT ["app/test.sh"]
