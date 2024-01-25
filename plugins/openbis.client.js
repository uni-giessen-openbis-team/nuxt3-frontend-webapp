export default defineNuxtPlugin(nuxtApp => {
    nuxtApp.provide('openbis', async () => {
      const openbis = await import('http://localhost:3000/openbis/resources/api/v3/openbis.esm.js');
  
      // Use the imported module directly
      const openbisInstance = new openbis();
  
      return openbisInstance;
    });
  });