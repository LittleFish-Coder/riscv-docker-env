# 使用 x86_64 版本的 Ubuntu 24.04
FROM --platform=linux/amd64 ubuntu:24.04

# 避免安裝過程中的交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安裝基本工具
RUN apt-get update && apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    curl \
    python3 \
    python3-pip \
    libmpc-dev \
    libmpfr-dev \
    libgmp-dev \
    gawk \
    build-essential \
    bison \
    flex \
    texinfo \
    gperf \
    libtool \
    patchutils \
    bc \
    zlib1g-dev \
    libexpat-dev \
    ninja-build \
    git \
    cmake \
    libglib2.0-dev \
    device-tree-compiler \
    libboost-regex-dev \
    libboost-all-dev \
    nano \
    vim \
    sudo

# 設置 RISCV 環境變數
ENV RISCV=/opt/riscv
ENV PATH=$RISCV/bin:$PATH

# 建立必要的目錄
RUN mkdir -p $RISCV && \
    mkdir -p $RISCV/bin

# 建立一個非 root 用戶
RUN useradd -m -s /bin/bash fish && \
    echo "fish:8008" | chpasswd && \
    adduser fish sudo && \
    echo "fish ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 切換到工作目錄
WORKDIR /home/fish

# 設置工作目錄的權限
RUN chown -R fish:fish /home/fish

# 切換到非 root 用戶
USER fish