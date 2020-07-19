FROM tsl0922/ttyd:alpine
apk add --no-cache --virtual .build-deps curl iftop mtr curl net-tools iperf3 htop tmux nano openssh-client
