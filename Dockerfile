FROM tsl0922/musl-cross
RUN git clone --depth=1 https://github.com/tsl0922/ttyd.git /ttyd \
    && cd /ttyd && ./scripts/cross-build.sh x86_64

FROM alpine:3.10
COPY --from=0 /ttyd/build/ttyd /usr/bin/ttyd
RUN apk add --no-cache bash tini curl iftop mtr curl net-tools iperf3 htop tmux nano openssh-client

EXPOSE 7681

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["ttyd", "-P", "3600", "bash"]
