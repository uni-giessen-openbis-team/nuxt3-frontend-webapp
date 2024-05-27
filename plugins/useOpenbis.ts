export default defineNuxtPlugin( async nuxtApp => {
     await useOpenBisStore().initialize().then(async () => {
      await useOpenBisStore().autoLogin() // auto login can be removed
      console.log('OpenBIS initialized');
    }).catch(error => {
      console.error('Failed to initialize OpenBIS:', error);
    });
});