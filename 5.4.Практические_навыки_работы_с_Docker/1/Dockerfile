FROM archlinux:latest
RUN pacman-db-upgrade && pacman -Syyu --noconfirm
RUN pacman -Sy --noconfirm ponysay
ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology”]