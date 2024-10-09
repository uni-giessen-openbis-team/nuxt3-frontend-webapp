<template>
    <v-textarea v-model="textInput" />
</template>

<script setup lang="ts">
const [modelValue] = defineModel<string[]>();
const textInput = computed({
    get: () => modelValue.value?.join('\n') ?? '', // Convert list to string
    set: (value: string) => {
         modelValue.value = value.split('\n'); // Split the string by newlines
    }
});
</script>