<script setup lang="ts">
import openbis from '~/composables/openbis.esm';

const modelValue = defineModel<openbis.DataSetType>({ required: true });

// getDatasets
const datasets: Ref<openbis.DataSetType[]> = ref([]);
onMounted(async () => {
  datasets.value = await useTypesStore().getDataSetTypes();
  console.log(datasets.value);
})

</script>

<template> 
  <div>
    <v-select :items="datasets" item-title="code" item-value="code" v-model="modelValue"></v-select>
  </div>
</template>