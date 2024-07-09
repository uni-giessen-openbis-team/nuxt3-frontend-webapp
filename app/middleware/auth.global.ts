export default defineNuxtRouteMiddleware(async (to, from) => {
  const openBisStore = useOpenBisStore()

  if (!await openBisStore.isLoggedIn) {
    if (to.path !== '/login') {
      return navigateTo('/login') 
    }
  }
})
