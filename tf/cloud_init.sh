#!/bin/bash
sudo useradd -m -p P$ssw0rd2021! ans
sudo mkdir /home/ans/.ssh/
sudo chmod 0700 /home/ans/.ssh/
sudo -- sh -c "echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0MJ2IZSmowimybBxhjK9o3e7dbDfnjbgkoWacyL1+L' > /home/ans/.ssh/authorized_keys"
sudo chown -R ans:ans /home/ans/.ssh/
usermod -aG sudo ans
