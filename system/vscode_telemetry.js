#!/usr/bin/env node

const path = "/usr/lib/code-server/lib/vscode/product.json"
const object = require(path)
const fs = require("fs")

object["enableTelemetry"] = false

fs.writeFileSync(
    path,
    JSON.stringify(
        object,
        null,
        4
    )
)

