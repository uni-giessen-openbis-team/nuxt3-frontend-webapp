export function useLogger() {
  const info = (message: string, ...args: any[]) => {
    console.log(`INFO: ${message}`, ...args)
  }

  const error = (message: string, ...args: any[]) => {
    console.error(`ERROR: ${message}`, ...args)
  }

  return {
    info,
    error,
  }
}
