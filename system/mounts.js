#!/usr/bin/env node

const fs = require("fs").promises
const path = require("path")
const mounts = require("/codec/.codec/mounts.json")

const mounts2 = {}
let targets = Object.keys(mounts).map(
    (key) => {
        const target = path.normalize("/codec/mounts/" + key)
        mounts2[target] = mounts[key]
        return target
    }
)

async function func() {
    await Promise.all(
        targets.map(createTargetLink)
    )
    console.info("Done!")
}
func()

async function createTargetLink(
    target
) {
    for (const target2 of targets.filter((target2) => target2 != target)) {
        if (target.startsWith(target2)) {
            console.info("### Wait for '" + target2 + "' before create '" + target + "'")
            return
        }
    }
    console.info("### Create link for '" + target + "'")
    let link = mounts2[target]
    if (!link.startsWith("/")) {
        link = "/codec/mounts/" + link
    }
    link = path.normalize(link)
    console.info("### Create link and target parent dirs if not exist!")
    await Promise.all([
        fs.mkdir(
            path.dirname(target),
            {
                recursive: true
            }
        ),
        fs.mkdir(
            path.dirname(link),
            {
                recursive: true
            }
        )
    ])
    await codecLink(
        link,
        target
    )
    targets = targets.filter((target2) => target2 != target)
    for (const target2 of targets) {
        if (target2.startsWith(target)) {
            await createTargetLink(target2)
        }
    }
}

async function codecLink(
    link,
    target
) {
    if (await exists(target)) {
        if (await exists(link)) {
            console.debug("remove file at link: " + link)
            await fs.rm(
                link,
                {
                    recursive: true,
                    force: true,
                }
            )
        }
    } else {
        if (await exists(link)) {
            console.debug("copy file at link path to target: " + link + " > " + target)
            await fs.cp(
                link,
                target,
                {
                    recursive: true,
                    force: true,
                }
            )
            await fs.rm(
                link,
                {
                    recursive: true,
                    force: true,
                }
            )
        } else {
            console.debug("create target dir: " + target)
            await fs.mkdir(
                target,
                {
                    recursive: true,
                }
            )
        }
    }
    console.debug("link: " + link + " > " + target)
    await fs.symlink(
        target,
        link,
    )
}

async function exists(
    path
) {
    try {
        const stat = await fs.stat(path)
        return stat.isDirectory() || stat.isFile()
    } catch (e) { }
    return false
}