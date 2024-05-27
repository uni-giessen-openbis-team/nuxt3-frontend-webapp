<script setup lang="ts">
import { ref, watch, defineProps, defineEmits } from 'vue';
import openbis from '~/composables/openbis.esm';
const props = defineProps({
  space: {
    type: openbis.Space,
    required: true
  },
  modelValue: {
    type: String,
    required: true
  },
  label: {
    type: String,
    required: true
  }
});

const emit = defineEmits(['update:modelValue']);

const person = ref(props.modelValue);
const persons = ref<openbis.RoleAssignment[]>([]);
const projectPersons = ref([]);

const personStore = usePersonStore();

watch(() => props.space, async (newSpace) => {
  if (newSpace) {
      console.log("🚀 ~ watch ~ newSpace:", newSpace)
      // Load the persons from the API based on the passed space prop
      persons.value  = await personStore.listPersonsOfSpace(newSpace);
      console.log("🚀 ~ watch ~ persons.value:", persons.value[0])
      
  }
}, { immediate: true });

watch(person, (newPerson) => {
  emit('update:modelValue', newPerson);
});
</script>

<template>

      <v-autocomplete
        v-model="person"
        :items="persons"
        :label="props.label"
        :rules="[value => !!value || 'Item is required']"
        item-text="user.id"
      />

  </template>