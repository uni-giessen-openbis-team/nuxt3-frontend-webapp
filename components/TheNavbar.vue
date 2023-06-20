<script setup>
// TODO: fix disapearing navbar
import { ref } from 'vue'
import { useDisplay } from 'vuetify'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

const { mdAndUp } = useDisplay()
console.log('🚀 ~ file: TheNavbar.vue:8 ~ mdAndUp:', mdAndUp.value)
const store = useOpenBisStore()

const navItems = [
  { name: 'Home', icon: 'mdi-home', path: '/' },
  { name: 'Workflows', icon: 'mdi-sitemap', path: '/workflows' },
  { name: 'Testing', icon: 'mdi-account-question', path: '/testing' },
]

const menuItems = [
  { name: 'Settings', icon: 'mdi-account-cog', path: '/settings' },
]
const tempDrawer = ref(true)

const userId = ref(store.sessionInformation?.permId.userId)
</script>

<template>
  <v-app-bar app>
    <!-- The Icon on the left to open and close the drawer -->
    <v-app-bar-nav-icon
      class="hidden-md-and-up"
      @click="tempDrawer = !tempDrawer"
    />
    <v-spacer />
    <nuxt-link to="/" class="d-flex align-items-center">
      <img src="/logo.png" alt="Logo" height="80" width="80">
    </nuxt-link>
    <v-spacer />
    <!-- Icons on the right side -->
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

  <!-- Add a navigation drawer on the left side on small screens -->
  <v-navigation-drawer
    v-model="tempDrawer"
    :permanent="mdAndUp.value"

    app
  >
    <!-- Navigation links on medium to small -->
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
