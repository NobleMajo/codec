import { CmdDefinition, BoolFlag, ValueFlag } from "cmdy"
import { cmdyFlag } from "typenvy"
import env from "../env/envParser"
import { envData } from "../env/envParser"

import * as express from "express"

export const httpPort: ValueFlag = cmdyFlag(
    {
        name: "port",
        alias: ["http-port"],
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
        name: "host",
        alias: ["b-h-a", "bha", "bind-host-address", "bind-address", "bind-host-address"],
        shorthand: "b",
        types: ["string"],
        description: "Set the host where the server pind the ports",
    },
    "BIND_ADDRESS",
    envData
)

const root: CmdDefinition = {
    name: "codec-prodiver-backend",
    description: "Codec provider backend",
    details: "A backend for codec",
    flags: [
        httpPort,
        trustAllCerts,
        bindHostAddress,
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

        console.info("PORT: " + env.HTTP_PORT)

        const app = express()

        app.use((req, res) => {
            console.info("req: " + req.socket.localAddress + ":" + req.socket.localPort)
            res.send("NO! NO! NO!")
        })

        app.listen(env.HTTP_PORT, env.BIND_ADDRESS, () => {
            console.info(
                "Codec provider backend listen on " +
                env.BIND_ADDRESS + ":" + env.HTTP_PORT
            )
        })
    }
}

export default root