# old
- [old](#old)
- [about](#about)
- [file system](#file-system)
- [software](#software)
- [codec components](#codec-components)

# about
The old codec file structure, software and features.

# file system
```md
- home  
  - codec
    - .codec
      - bin
      - skel
      - docker-entrypoint.sh
    - ws                    <- synced/mounted
      - .codec
        - bin
        - boot.sh
        - bash.sh
        - default.code-workspace
        - ports.txt
        - ...etc...
      - main
      - todo
      - test
```

# software
 - ubuntu v20.04
 - vscode server v3
 - dind
 - git
 - node v16
 - npm v8
 - unminimize docke image
  
# codec components
 - codec bins
 - codec linux user
 - boot and bash script