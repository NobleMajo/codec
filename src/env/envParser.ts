import { parseEnv } from "typenvy"
import { envTypes, envDefaults } from "./env"
import { trustAllCerts } from '../cmd/root';

export const envData = parseEnv(
    envDefaults,
    envTypes,
)
    .setProcessEnv()
    .errExit()
export const env = envData.env
export default env
