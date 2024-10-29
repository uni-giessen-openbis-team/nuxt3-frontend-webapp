<template>
<v-app>
        <Explorer @space-selected="handleSpaceSelected"/>
</v-app>
</template>


<script setup lang="ts">
import type openbis from '@/composables/openbis.esm'
import Explorer from './Explorer.vue'


function handleSpaceSelected(space: openbis.Space) {
    console.log('Space selected:', space)
}


</script>

