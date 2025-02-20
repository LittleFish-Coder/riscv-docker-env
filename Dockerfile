# 使用 x86_64 版本的 Ubuntu 24.04
FROM --platform=linux/amd64 ubuntu:24.04

# 避免安裝過程中的交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 只安裝 sudo 和基本工具
RUN apt-get update && apt-get install -y \
    sudo \
    git

# 建立一個非 root 用戶並設置為 sudoer
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