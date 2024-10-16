export default defineNuxtPlugin( async () => {
     await useOpenBisStore().initialize().then(async () => {
      await useOpenBisStore().autoLogin() // Todo: auto login neeed be removed in production
    }).catch(error => {
      console.error('Failed to initialize OpenBIS:', error);
    });
});