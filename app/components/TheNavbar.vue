<script setup>
// TODO: fix disapearing navbar
import { ref } from 'vue'
import { useDisplay } from 'vuetify'
const { mdAndUp } = useDisplay()

const navItems = [
  { name: 'Notebooks', icon: 'mdi-book', path: '/data/spaces' },
  { name: 'Samples', icon: 'mdi-test-tube', path: '/data/spaces/MATERIALS/20240617092410825-595/20240617102725716-600' },
  { name: 'Workflows', icon: 'mdi-sitemap', path: '/workflows' },
]
const menuItems = [
  { name: 'Settings', icon: 'mdi-account-cog', path: '/settings' },
  { name: 'Information', icon: 'mdi-information', path: '/Information' },
]
const tempDrawer = ref(true)

</script>

<template>
  
  <v-app-bar app>
    <!-- The Icon on the left to open and close the drawer -->
    <v-app-bar-nav-icon class="hidden-lg-and-up" @click="tempDrawer = !tempDrawer" />
    <nuxt-link to="/" class="d-flex align-items-center">
      <v-img src="/logo.webp" alt="Logo" height="80" width="80" />
    </nuxt-link>
    <v-app-bar-title>Project Safe</v-app-bar-title>

    <v-spacer /> 

    <v-spacer />
    <!-- Icons on the right side -->
    <!-- Settings Menu -->
    <v-menu transition="scale-transition">
      <template #activator="{ props }">
        <v-btn color="primary" v-bind="props">
          <v-icon> mdi-dots-vertical </v-icon>
        </v-btn>
      </template>

      <v-list>
        <v-list-item v-for="routeItem in menuItems" :key="routeItem.name" :to="routeItem.path">
          <template #prepend>
            <v-icon>{{ routeItem.icon }}</v-icon>
          </template>
          <v-list-item-title>{{ routeItem.name }}</v-list-item-title>
        </v-list-item>
        <v-list-item>
          <Logout />
        </v-list-item>
      </v-list>
    </v-menu>
  </v-app-bar>

  <!-- Add a navigation drawer on the left side on small screens -->

  <v-navigation-drawer v-model="tempDrawer" :permanent="mdAndUp.value" app>
    <AtomsSidebar />
  </v-navigation-drawer>

</template>
