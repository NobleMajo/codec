import { CmdDefinition, BoolFlag, ValueFlag } from "cmdy"
import env from "../env/envParser"
import * as dns from "dns"
import { cmdyFlag } from "typenvy"
import { envData } from "../env/envParser"

export const httpPort: ValueFlag = cmdyFlag(
    {
        name: "http-port",
        alias: ["http"],
        shorthand: "p",
        types: ["number"],
        description: "Set the http port (default: 80 but disabled if any port is set)",
    }
    ,
    "HTTP_PORT",
    envData
)

export const trustAllCerts: BoolFlag = cmdyFlag(
    {
        name: "trust-all-certs",
        alias: ["t-a-c", "tac"],
        shorthand: "t",
        description: "Trust all certificates on proxy",
    },
    "TRUST_ALL_CERTS",
    envData
)

export const bindHostAddress: ValueFlag = cmdyFlag(
    {
        name: "bind-host-address",
        alias: ["b-h-a", "bha", "bind-host-address", "bind-address"],
        shorthand: "b",
        types: ["string"],
        description: "Set the host where the server pind the ports",
    },
    "BIND_ADDRESS",
    envData
)

export const dnsServerAddress: ValueFlag = cmdyFlag(
    {
        name: "dns-server-address",
        alias: ["dns-server", "dnsserveraddress", "dns-address", "dns"],
        types: ["string"],
        description: "Add a dns address to the existing dns addresses",
        multiValues: true,
    },
    "DNS_SERVER_ADDRESSES",
    envData
)

const root: CmdDefinition = {
    name: "cprox",
    description: "CProX is a easy to configure redirect, proxy and static webserver",
    details: "You can use CProX as webserver. It can proxy, redirect and service static content on requests",
    flags: [
        httpPort,
        trustAllCerts,
        bindHostAddress,
        dnsServerAddress,
    ],
    allowUnknownArgs: true,
    cmds: [
    ],
    exe: async (cmd) => {
        console.info("Start codec provider backend...")

        env.VERBOSE && console.debug(
            "VERBOSE MODE ENABLED!\n",
            "ENV:",
            JSON.stringify(env, null, 2),
            "\n\n"
        )

        dns.setServers(env.DNS_SERVER_ADDRESSES)

        console.info("test data: ", cmd.valueFlags)
        console.info("test data: ", cmd.arrayFlags)
        console.info("test data: ", cmd.flags)

        let httpPort = Number(cmd.valueFlags["http-port"])

        console.info("Test: " + httpPort)
    }
}

export default root