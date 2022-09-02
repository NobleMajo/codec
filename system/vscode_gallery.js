#!/usr/bin/env node

const path = "/usr/lib/code-server/lib/vscode/product.json"
const object = require(path)
const fs = require("fs")

if (typeof process.env["VSCODE_GALLERY"] != "string") {
    process.env["VSCODE_GALLERY"] = "ms"
}

if (process.env["VSCODE_GALLERY"].startsWith("open")) {
    object["extensionsGallery"] = {
        "serviceUrl": "https://open-vsx.org/vscode/gallery",
        "itemUrl": "https://open-vsx.org/vscode/item"
    }
} else if (process.env["VSCODE_GALLERY"].startsWith("ms2")) {
    object["extensionsGallery"] = {
        "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
        "itemUrl": "https://marketplace.visualstudio.com/items",
        "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index",

        "nlsBaseUrl": "https://www.vscode-unpkg.net/_lp/",
        "publisherUrl": "https://marketplace.visualstudio.com/publishers",
        "resourceUrlTemplate": "https://{publisher}.vscode-unpkg.net/{publisher}/{name}/{version}/{path}",
        "controlUrl": "https://az764295.vo.msecnd.net/extensions/marketplace.json",
        "recommendationsUrl": "https://az764295.vo.msecnd.net/extensions/workspaceRecommendations.json.gz"
    }
} else {
    object["extensionsGallery"] = {
        "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
        "itemUrl": "https://marketplace.visualstudio.com/items",
        "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index"
    }

}

fs.writeFileSync(
    path,
    JSON.stringify(
        object,
        null,
        4
    )
)
