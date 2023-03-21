<script setup lang="ts">
interface DataItem {
  heading: string
  icon: string
  text: string
}

const props = defineProps({
  cardData: {
    type: Array as () => Array<DataItem>,
    default: () => [],
  },
})
</script>

<template>
  <div v-for="item in props.cardData" :key="item.heading">
    <v-card>
      <div> {{ item.heading }} </div>
    </v-card>
  </div>
</template>

<style scoped>

</style>
