FROM ciscotestautomation/pyats:latest-alpine

ENV JAVA_HOME "/usr"

RUN apk add --update \
    dbus \
    dbus-x11 \
    mesa-gles \
    llvm \
    setup-xorg-base \
    xfce4 \
    xfce4-terminal \
    xfce4-screensaver \
    lightdm-gtk-greeter \
    elogind \
    polkit-elogind \
    adwaita-icon-theme \
    gvfs-smb \
    openjdk11 \
    git \
    openssh \
    openssh-keygen \
    openssl \
    libxml2-dev \
    libxslt-dev \
    sshpass \
    wget \
    docker \
    docker-cli-compose \
    sudo \
    curl \
    gpg \
    py3-pyte \
    ansible \
    ansible-lint \
    remmina \
    badwolf \
    direnv
RUN pip3 install --upgrade pip
RUN apk --update add --virtual \
        .build-deps \
        gcc \
        libffi-dev \
        openssl-dev \
        build-base \
 && pip3 install --upgrade \
        ncclient \
        ansible-vault \
        cmlutils\
        robotframework-seleniumlibrary \
        robotframework-sshlibrary \
        robotframework-requests \
        robotframework-winrmlibrary \
        robotframework-robocop \
        pywinrm \
        robotframework-requests \
        RESTinstance \
        ruff \
        code-oss \
        netapp-lib \
        infoblox-client \
        pyats[full] \
 && apk del \
        .build-deps \
 && rm -rf /var/cache/apk/*

RUN echo -e """\
\n\
Host *\n\
    PasswordAuthentication yes\n\
    StrictHostKeyChecking no\n\
    UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config

RUN setup-devd udev
RUN rc-service lightdm start
RUN rc-update add lightdm
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
RUN adduser jenkins wheel
RUN adduser -D jenkins && (echo "jenkins:jenkins" | chpasswd) && (echo "root:root" | chpasswd)

ADD .ansible.cfg /home/jenkins/
ADD .profile /home/jenkins/

RUN chown -R jenkins:jenkins /home/jenkins

ADD docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
EXPOSE 22 
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
