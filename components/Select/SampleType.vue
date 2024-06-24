<script setup lang="ts">
import openbis from '~/composables/openbis.esm';

const modelValue = defineModel<openbis.SampleType>({ required: true });

// getSampleTypes
const sampleTypes: Ref<openbis.SampleType[]> = ref([]);
onMounted(async () => {
   sampleTypes.value = await useTypesStore().getSampleTypes();
  console.log(sampleTypes.value);
})

</script>

<template> 

  <div>
    <v-select :items="sampleTypes" item-title="code" item-value="code" v-model="modelValue"></v-select >
  </div>
</template>
