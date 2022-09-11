import { BoolFlag, CmdParserOptions, parseCmd, ValueFlag } from "cmdy"
import { cmdyFlag } from "typenvy"
import root from "./cmd/root"
import env, { envData } from "./env/envParser"
import * as dns from "dns"

export const trustAllCerts: BoolFlag = cmdyFlag(
    {
        name: "trustcerts",
        alias: ["trust-all-certs", "trust-all", "trust-certs"],
        shorthand: "t",
        description: "Show basic flag adn target informations",
        exe: () => {
            if (env.TRUST_ALL_CERTS) {
                process.env["NODE_TLS_REJECT_UNAUTHORIZED"] = "0"
            }
        }
    },
    "TRUST_ALL_CERTS",
    envData
)

export const dnsServerAddress: ValueFlag = cmdyFlag(
    {
        name: "dns-server-address",
        alias: ["dns-server", "dnsserveraddress", "dns-address", "dns"],
        types: ["string"],
        description: "Add a dns address to the existing dns addresses",
        multiValues: true,
        exe: () => dns.setServers(env.DNS_SERVER_ADDRESSES)
    },
    "DNS_SERVER_ADDRESSES",
    envData
)

export const verbose: BoolFlag = cmdyFlag(
    {
        name: "verbose",
        shorthand: "v",
        description: "Show basic flag adn target informations",
    },
    "VERBOSE",
    envData
)

export const cmdOptions: CmdParserOptions = {
    cmd: root,
    globalFlags: [
        trustAllCerts,
        dnsServerAddress,
        verbose,
    ],
    globalHelpMsg: "! Codec Provider Backend | by majo418 | supported by CoreUnit.NET !",
}

export default parseCmd(cmdOptions)
    .exe()
    .catch((err: Error | any) => console.error(
        "# Codec Provider Backend Error #\n", err
    ))
