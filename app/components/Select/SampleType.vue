<script setup lang="ts">
import type openbis from '~/composables/openbis.esm';

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
    <v-select v-model="modelValue" :items="sampleTypes" item-title="code" item-value="code"/>
  </div>
</template>
