<script setup>
import { ref } from 'vue'
import CustomTextInput from './CustomTextInput.vue'
import Message from './Message.vue'

const msg = ref('msg')
const firstName = ref('')
</script>

<template>
  ]
  <div>
    <h4>defineModel: </h4>
    <CustomTextInput v-model:text="firstName" />
    Name: {{ firstName }}
  </div>
  <div>
    <h4>defineModel: </h4>
    <Message v-model:msg="msg" />
  </div>
</template>
