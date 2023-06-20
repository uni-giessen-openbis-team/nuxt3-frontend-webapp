<script setup lang="ts">
const online = useOnline()
</script>

<template>
  <div>
    <Suspense>
      <ClientOnly>
        <TheHome v-if="online" />
        <div v-else text-gray:80>
          You're offline
        </div>
      </ClientOnly>
      <template #fallback>
        <div op50 italic>
          <span animate-pulse>Loading...</span>
        </div>
      </template>
    </Suspense>
  </div>
</template>
