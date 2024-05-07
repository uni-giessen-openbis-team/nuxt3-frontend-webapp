export default defineNuxtPlugin( async nuxtApp => {
     await useOpenBisStore().initialize().then(() => {
      console.log('OpenBIS initialized');
    }).catch(error => {
      console.error('Failed to initialize OpenBIS:', error);
    });
});