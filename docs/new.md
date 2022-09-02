# new
- [new](#new)
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
        - 
      - mounts
        - vscode
    - ports.info.txt
- root  
  - ws -> /codec
- usr
  - bin <- codec bins moved
- /codec/
  - .codec/
    - bin <- custom bins moved
    - scripts/
      - enabled/
        - mount.boot.sh
        - env.bash.sh
        - ssh.bash.sh
        - git.async.sh
        - npm.async.sh
        - vscode.async.sh
        - apt.boot.sh
      - disabled/
        - dockerd.async.sh
        - btop.async.sh
        - marketplace.boot.sh
    - logs/
    - mounts.json
  - mounts/
    - systemd -> /etc/systemd/system
    - ssh -> /root/.ssh
    - vscode -> /root/.local/share/code-server
  - main/
  - todo/
  - archieved/
```

# software
 - \- unminimize container
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