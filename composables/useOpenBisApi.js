import { OpenBisApi } from './path/to/your/openbis-api-class'

export default function useOpenBisApi() {
  const openBisApi = new OpenBisApi('http://localhost:3000/openbis/resources/api/v3')

  const connect = async () => {
    await openBisApi.connect()
  }

  const disconnect = async () => {
    await openBisApi.disconnect()
  }

  const searchSpaces = async () => {
    const spaces = await openBisApi.searchSpaces()
    return spaces
  }

  return {
    connect,
    disconnect,
    searchSpaces,
  }
}
