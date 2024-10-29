 <!-- 
  This component is used to display the tree view of the spaces.
  sapce / projects / experiments 
 -->

<template>
    <!-- <v-treeview :items="filteredSpaces" item-title="code" /> -->

    <v-list >
        <v-list-item
            v-for="item in filteredSpaces"
            :key="item.getId().toString()"
            :title="item.getCode()"
            prepend-icon="mdi-folder"
            :to="`/spaces/${item.getCode().toString()}`"
             @click="handleClick(item)"
            />
    <v-divider/>
    <v-list-item title="Labbooks"/>
        <v-list-item
            v-for="item in filteredLabbookSpaces"
            :key="item.getId().toString()"
            :title="item.getCode()"
            prepend-icon="mdi-folder"
            :to="`/spaces/${item.getCode().toString()}`"
              @click="handleClick(item)"
            />
          
    </v-list>
  </template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { getAllSpaces } from '@/composables/api-connector/spaces'
import type openbis from '@/composables/openbis.esm'

const emit = defineEmits<{
  (event: 'space-selected', space: openbis.Space): void;
}>();

const spaces = ref<openbis.Space[]>([])

const categories = ['STORAGE', 'MATERIALS', 'METHODS', 'STOCK_CATALOG', 'STOCK_ORDERS', 'PUBLICATIONS', 'ELN_SETTINGS']

const filteredSpaces = computed(() => {
  const includedSpaces = spaces.value.filter(space => categories.includes(space.getCode()))
  return includedSpaces
})

const filteredLabbookSpaces = computed(() => {
  return spaces.value.filter(space => !categories.includes(space.getCode()))
})


// const treeViewItems = computed(() => {
//   return filteredSpaces.value.map(space => ({
//     id: space.code(),
//     name: space.code(),
//     children: space.projects.map(project => ({
//       id: project.getPermId().toString(),
//       name: project.code 
//     }))
//   }));
// });

onMounted(async () => {
  try {
    spaces.value = await getAllSpaces();
    console.log('Spaces:', spaces.value);
    // for (let i = 0; i < spaces.value.length; i++) {
    //   const space = spaces.value[i];
    //   space.setProjects(await getProjectsOfSpace(space.getCode()));
    // }
  } catch (error) {
    console.error('Failed to load spaces:', error);
  }
})


// Function to handle click events on list items
function handleClick(item: openbis.Space) {
  console.log('Clicked item:', item)
  emit('space-selected', item)
}
</script>

