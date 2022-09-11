import { parseEnv } from "typenvy"
import { envTypes, envDefaults } from "./env"

export const envData = parseEnv(
    envDefaults,
    envTypes,
)
    .setProcessEnv()
    .errExit()
export const env = envData.env
export default env
