# Script for auto fan control of nvidia gpu in linux

## Steps:

### 1) enable coolbits with command:

```bash
  nvidia-xconfig --cool-bits=4
```

### 2) put sh script in the home folder

### 3) put service in /etc/systemd/system/

### 4) enable the service and reload systemd

```bash
  systemctl enable fan_control.service
  sudo systemctl daemon-reload
```
