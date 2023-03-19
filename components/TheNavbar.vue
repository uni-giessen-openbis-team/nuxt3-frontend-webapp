<script setup>
import { ref } from 'vue'
const menuItems = [
  { title: 'Home', link: '/', icon: 'mdi-home' },
  { title: 'Workflows', link: '/workflows', icon: 'mdi-account-convert' },
]

const settingItems = [
  { title: 'setting1', link: '/', icon: 'mdi-home' },
  { title: 'setting2', link: '/workflows', icon: 'mdi-account-convert' },
  { title: 'setting13', link: '/workflows', icon: 'mdi-account-convert' },
]

const drawer = ref(false)
</script>

<template>
  <!-- Navigation on the top of the page -->
  <v-app-bar app color="secondary">
    <v-app-bar-nav-icon class="hidden-lg-and-up" @click="drawer = !drawer" />
    <v-spacer />
    <v-btn v-for="(item, index) in menuItems" :key="index" :to="item.link" text>
      {{ item.title }}
    </v-btn>
  </v-app-bar>

  <!-- Navigation at the left side of the page -->
  <v-navigation-drawer
    v-model="drawer"
    app
    :permanent="$vuetify.breakpoint.isLargeAndUp"
    :temporary="!$vuetify.breakpoint.isLargeAndUp"
  >
    <v-list>
      <v-list-item v-for="(item, index) in menuItems" :key="index" :to="item.link">
        <v-icon>{{ item.icon }}</v-icon>
        {{ item.title }}
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>
