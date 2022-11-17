#!/usr/bin/env node

(
    async () => {
        let fetch
        try {
            fetch = require("./node_modules/node-fetch/lib/index")
        } catch (err) {
            if (err.message.startsWith("Cannot find module")) {

            }
            const { exec } = require("child_process");

            let err3
            await new Promise((res) => {
                exec("npm ci", (err2, stdout, stderr) => {
                    if (err2) {
                        err3 = err2
                    } else if (stderr) {
                        err3 = new Error("Error outpus:", stderr)
                    }
                    res()
                })
            })
            if (err3) {
                console.error("Error while install npm deps: ", err3)
                process.exit(1)
            }

            fetch = require("./node_modules/node-fetch/lib/index")
        }


        const url = "https://api.github.com/repos/coder/code-server/releases"
        const resp = await fetch(url)
        const data = await resp.json()
        for (const releases of data) {
            if (
                typeof releases["tag_name"] == "string" &&
                releases["tag_name"] == releases["name"] &&
                releases["target_commitish"]
                    .endsWith(releases["name"])
            ) {
                let v = releases["tag_name"]
                if (v.startsWith("v")) {
                    v = v.substring(1)
                }
                process.stdout.write(v)
                process.exit(0)
            }
        }
        process.stderr.write(
            "No version found!"
        )
        process.exit(1)
    }
)()
