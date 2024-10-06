<script setup lang="ts">
const emit = defineEmits(['update:modelValue'])

const textInput = ref('')
onMounted(() => {
  watchEffect(() => {
    const list = textInput.value.split('\n')
    emit('update:modelValue', list)
  })
})

</script>
 
<template>
  <div>
    <v-textarea v-model="textInput" />
  </div>
</template>
 