<script setup>
import { defineProps, ref, toRefs } from 'vue'

const props = defineProps({
  items: Array,
})

const { items } = toRefs(props)
const tab = ref(items.value ? items.value[0] : '')

onMounted(() => {
  console.log(items.value)
})
</script>

<template>
 
</template>
