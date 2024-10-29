<template>
    <div>
        <Create :name="name" :create-function="createFunction"/>
    </div>
</template>

<script setup lang="ts">
import Create from './Create.vue'

// In the component it shows "creeate Labbook". 
const name = "Labbook"

async function createFunction(name: string, description?: string) {
    createSpace(name, description)
}

</script>

