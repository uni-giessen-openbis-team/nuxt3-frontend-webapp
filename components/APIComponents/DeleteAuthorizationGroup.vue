<script setup lang="ts">
import { useOpenBisStore } from '@/composables/openbisAPI'
const store = useOpenBisStore()

const authorizationGroups = await store.getAuthorizationGroups()
</script>

<template>
  <v-list>
    <v-list-item v-for="item in authorizationGroups" :key="item.code">
      <v-list-item-title>{{ item.code }}</v-list-item-title>
      <v-list-item-subtitle>{{ item.description }}</v-list-item-subtitle>
    </v-list-item>
  </v-list>
</template>
