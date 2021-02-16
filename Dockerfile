FROM tsl0922/musl-cross
RUN git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && ./scripts/cross-build.sh x86_64

FROM alpine:3.10
COPY --from=0 /ttyd/build/ttyd /usr/bin/ttyd
RUN apk add --no-cache bash tini curl iftop mtr curl net-tools iperf3 htop tmux nano openssh-client openssh tzdata openrc && \ 
    mkdir -p /run/openrc && \
    touch /run/openrc/softlevel && \
    rc-update add sshd default && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    echo "root:admin" | chpasswd

EXPOSE 7681

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "-P", "3600", "bash"]
