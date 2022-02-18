# syntax=docker/dockerfile:experimental

FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04

USER root
SHELL ["/bin/bash", "-c"]

COPY installer/phoxi.run /tmp/phoxi.run
COPY system_files/PhoXiControl /usr/local/bin/PhoXiControl

ENV PHOXI_CONTROL_PATH="/opt/Photoneo/PhoXiControl"

RUN set -eux \
    && cd /tmp \
    && apt-get update -y \
    && apt-get install -y -q software-properties-common && apt-add-repository universe \
    && apt-get update -y \
    # phoxicontrol dependencies (gui...)
    && apt install -y avahi-utils libqt5core5a libqt5dbus5 libqt5gui5 libgtk2.0-0 libssl1.0.0 libgomp1 libpcre16-3 libflann-dev libssh2-1-dev libpng16-16 libglfw3-dev \
    && chmod a+x phoxi.run \
    && ./phoxi.run --accept ${PHOXI_CONTROL_PATH} \
    && rm -rf phoxi.run

CMD ["/usr/local/bin/PhoXiControl"]
