ARG USERNAME=devenv
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG SDK_VERSION="8.0"
FROM mcr.microsoft.com/dotnet/sdk:${SDK_VERSION}
WORKDIR /EntityFrameworkMigrations

ARG USERNAME
ARG USER_UID
ARG USER_GID
RUN \
    groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} && \
    apt update && apt full-upgrade -y && \
    apt install sudo git ssh -y && \
    echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} 

USER ${USERNAME}
