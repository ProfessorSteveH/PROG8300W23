FROM ubuntu:20.04 as common


#stuoid timezone stuff
ENV TZ America/Toronto
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# User account
RUN groupadd -g 1000 prog8300
RUN useradd -d /shared -g 1000 -G sudo -M -u 1000 -s /bin/bash prog8300
RUN echo prog8300:p@ssw0rd | chpasswd

# Common deps
RUN apt-get update && \
    apt-get -y install build-essential \
					   sudo \
                       curl \
                       gpg \
                       graphviz \
		       libsecret-1-dev	\
                       python3 \
                       wget \
                       libzmq3-dev \
                       sqlite3 \ 
                       libgtk-3-dev \
                       xz-utils && \
    rm -rf /var/lib/apt/lists/*

RUN wget -nv https://download.owncloud.com/desktop/ownCloud/stable/latest/linux/Ubuntu_20.04/Release.key -O /tmp/Release.key && apt-key add /tmp/Release.key
RUN echo 'deb https://download.owncloud.com/desktop/ownCloud/stable/latest/linux/Ubuntu_20.04/ /' >>  /etc/apt/sources.list.d/owncloud.list
RUN apt update && apt install -y owncloud-client

FROM common

ARG LLVM=14

RUN apt-get update && \
    apt-get -y install libsecret-1-0 && \
    rm -rf /var/lib/apt/lists/*

#COPY --from=steve /home/steve /home/steve
WORKDIR /home/prog8300

# C/C++ Developer tools

# gcc 10 repository
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ubuntu-toolchain-r/test && \
    apt-get remove -y software-properties-common

# Install clangd and clang-tidy from the public LLVM PPA (nightly build / development version)
# And also the GDB debugger from the Ubuntu repos
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-$LLVM main" > /etc/apt/sources.list.d/llvm.list && \
    apt-get update && \
    apt-get install -y \
                       clang-tools-$LLVM \
                       clangd-$LLVM \
                       clang-tidy-$LLVM \
                       gcc-multilib \
                       g++-multilib \
                       gdb && \
    ln -s /usr/bin/clang-$LLVM /usr/bin/clang && \
    ln -s /usr/bin/clang++-$LLVM /usr/bin/clang++ && \
    ln -s /usr/bin/clang-cl-$LLVM /usr/bin/clang-cl && \
    ln -s /usr/bin/clang-cpp-$LLVM /usr/bin/clang-cpp && \
    ln -s /usr/bin/clang-tidy-$LLVM /usr/bin/clang-tidy && \
    ln -s /usr/bin/clangd-$LLVM /usr/bin/clangd

RUN chmod 755 /home

RUN chmod g+rw /home && \
    chown -R prog8300:prog8300 /home/prog8300 

RUN mkdir -p /shared && \
	chown -R prog8300:prog8300 /shared

COPY owncloud_loop.sh /usr/local/bin
RUN chmod 555 /usr/local/bin/owncloud_loop.sh 

#RUN rm /usr/bin/ssh /usr/bin/curl /usr/bin/wget /usr/bin/scp /usr/bin/sftp /usr/bin/slogin

#USER prog8300

ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins

# Configure sudo.
#RUN ex +"%s/^%sudo.*$/%sudo ALL=(ALL:ALL) NOPASSWD:ALL/g" -scwq! /etc/sudoers

RUN curl -fsSL https://code-server.dev/install.sh | sh

#RUN rm /usr/local/sbin/unminimize /usr/bin/curl

# Setup default command and/or parameters.
EXPOSE 8001
RUN chmod 755 /home/prog8300

USER prog8300
RUN mkdir /home/prog8300/code-server
COPY startup.sh /home/prog8300
COPY config.yaml /shared/.config/code-server/config.yaml
CMD ["bash", "/home/prog8300/startup.sh"]

