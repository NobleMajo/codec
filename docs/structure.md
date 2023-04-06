# structure
- [structure](#structure)
- [about](#about)
- [file system](#file-system)
- [software](#software)
- [codec components](#codec-components)

# about
The new codec file structure, software and features.

# file system
```md
- etc  
  - codec
    - boot.sh
    - bash.sh
    - health.sh
    - skel
      - .codec
        - ...skel...
      - mounts
        - vscode
    - ports.info.txt
- root  
  - ws -> /codec
- usr
  - bin <- codec bins moved to here
- /codec/             <- synced/mounted
  - .codec/
    - bin <- custom bins moved
    - modules/
    - optional/
      - env.bash.sh
      - ssh.bash.sh
      - git.async.sh
      - npm.async.sh
      - vscode.async.sh
      - apt.boot.sh
      - dockerd.async.sh
      - btop.async.sh
      - marketplace.boot.sh
      - zapt.boot.sh
    - mounts.json
  - mounts/
    - systemd <- /etc/systemd/system
    - ssh <- /root/.ssh
    - vscode <- /root/.local/share/code-server
  - main/
  - todo/
  - archieved/
```

# software
 - \- unminimize docker image
 - \- ubuntu v20.04
 - \+ ubuntu v22.04 (UPDATE LTS)
 - \- vscode server v3
 - \+ vscode server v4.6 (UPDATE)
 - \+ systemd (NEW)
 - \+ ssh server (WIP)
 - \+ nextcloud server (WIP)
 - dind
 - git
 - node v16
 - npm v8
  
# codec components
 - \- codec linux user
 - \- boot and bash script
 - \+ codec module system
 - \+ codec systemd service
 - \+ health check boot script
 - \+ custom bins
 - codec bins