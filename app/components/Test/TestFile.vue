<script setup>
const modelValue = defineModel() 
</script>

<template>
    <div>
        modelValue: {{ modelValue }}
    </div>
    Begin Textfield
    <v-text-field v-model="modelValue" label="First name"></v-text-field>
    End Textfield
    <v-combobox></v-combobox>
</template>
