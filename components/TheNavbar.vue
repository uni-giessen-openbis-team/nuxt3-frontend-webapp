<script setup>
import { ref } from 'vue'

const navItems = [
  { name: 'Home', icon: 'mdi-home', path: '/' },
  { name: 'Workflows', icon: 'mdi-sitemap', path: '/workflows' },
]

const menuItems = [
  { name: 'Settings', icon: 'mdi-account-cog', path: '/settings' },
]

const drawer = ref(false)
</script>

<template>
  <v-app-bar app>
    <!-- The Icon on the left to open and close the drawer -->
    <v-app-bar-nav-icon
      class="d-flex"
      @click="drawer = !drawer"
    />
    <v-spacer />
    <nuxt-link to="/" class="d-flex align-items-center">
      <img src="logo.png" alt="Logo" height="80" width="80">
    </nuxt-link>
    <v-spacer />
    <!-- Icons on the right side -->
    <!-- Search bar -->
    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>

    <!-- Settings Menu -->
    <v-menu
      transition="scale-transition"
    >
      <template #activator="{ props }">
        <v-btn
          color="primary"
          v-bind="props"
        >
          <v-icon> mdi-dots-vertical </v-icon>
        </v-btn>
      </template>

      <v-list>
        <v-list-item
          v-for="(item, i) in menuItems"
          :key="i"
        >
          <v-list-item-title>{{ item.name }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>

  <!-- Add a navigation drawer on the left side -->
  <v-navigation-drawer
    v-model="drawer"
    absolute
    temporary
  >
    <!-- Navigation Links -->
    <v-list
      :lines="false"
      density="compact"
      nav
    >
      <v-list-item v-for="routeItem in navItems" :key="routeItem.name">
        <nuxt-link :to="routeItem.path" class="text-decoration-none">
          <v-icon>{{ routeItem.icon }}</v-icon>
          {{ routeItem.name }}
        </nuxt-link>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>
