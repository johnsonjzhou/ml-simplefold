#!/bin/bash

# Get current user ID and group ID
USER_ID=$(id -u)
GROUP_ID=$(id -g)

# Mounts the port here for a jupyter instance
# Entrypoint will start jupyter lab
sudo docker run -it \
  -v .:/root \
  -p 9500:9500 \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  --device=/dev/kfd \
  --device=/dev/dri \
  --group-add video \
  --ipc=host \
  --shm-size 8G \
  --user ${USER_ID}:${GROUP_ID} \
  --entrypoint /bin/bash \
  rocm/pytorch/simplefold:latest \
  -c "chmod +x /root/scripts/start_jupyter.sh && /root/scripts/start_jupyter.sh"