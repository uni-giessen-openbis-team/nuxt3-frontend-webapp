<script setup lang="ts">
import openbis from '@/composables/openbis.esm'

const sessionInformation = await  useOpenBisStore().isLoggedIn
</script>

<template>
  <div>
    <pre>
        {{ sessionInformation }}
    </pre>

  </div>
</template>
