<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'

const store = useOpenBisStore()
const samples = ref([])

onMounted(async () => {
  samples.value = await store.listObjectsOfSpace('DEFAULT')
})
</script>

<template>
  <div>
    <div v-for="sample in samples" :key="sample">
      <div v-for="entry in sample" :key="entry">
        1
        <div if=" entry.code ">
          <pre> {{ entry.code }}</pre>
        <!-- <pre>{{ entry }} </pre> -->
        </div>
      </div>
    </div>
  </div>
</template>
