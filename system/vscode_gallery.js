#!/usr/bin/env node

const path = "/usr/lib/code-server/lib/vscode/product.json"
const object = require(path)
const fs = require("fs")

let gallery = process.env["VSCODE_GALLERY"]

if (
    typeof gallery != "string" ||
    gallery.length == 0
) {
    gallery = "ms"
}

function setOpenVSXGallery(object) {
    object["extensionsGallery"] = {
        "serviceUrl": "https://open-vsx.org/vscode/gallery",
        "itemUrl": "https://open-vsx.org/vscode/item"
    }

    object["linkProtectionTrustedDomains"] = [
        "https://open-vsx.org"
    ]
}

function setMicrosoftGallery(object) {
    object["extensionsGallery"] = {
        "nlsBaseUrl": "https://www.vscode-unpkg.net/_lp/",
        "serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery",
        "itemUrl": "https://marketplace.visualstudio.com/items",
        "publisherUrl": "https://marketplace.visualstudio.com/publishers",
        "resourceUrlTemplate": "https://{publisher}.vscode-unpkg.net/{publisher}/{name}/{version}/{path}",
        "controlUrl": "https://az764295.vo.msecnd.net/extensions/marketplace.json"
    }

    object["linkProtectionTrustedDomains"] = [
        "https://*.visualstudio.com", "https://*.microsoft.com",
        "https://aka.ms",
        "https://*.gallerycdn.vsassets.io",
        "https://*.github.com",
        "https://login.microsoftonline.com",
        "https://*.vscode.dev",
        "https://*.github.dev",
        "https://gh.io",
        "https://portal.azure.com",
        "https://raw.githubusercontent.com",
        "https://private-user-images.githubusercontent.com",
        "https://avatars.githubusercontent.com"
    ]
}

if (
    gallery.startsWith("ov") ||
    gallery.startsWith("open")
) {
    setOpenVSXGallery(object)
} else if (
    gallery.startsWith("ms") ||
    gallery.startsWith("microsoft")
) {
    setMicrosoftGallery(object)
}

fs.writeFileSync(
    path,
    JSON.stringify(
        object,
        null,
        4
    )
)
