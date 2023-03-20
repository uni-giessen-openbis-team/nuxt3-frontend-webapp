<script setup>
const pagerouts = [
  { name: 'Home', icon: 'bi-house-door', path: '/' },
  { name: 'Workflows', icon: 'bi-house-door', path: '/workflows' },
  { name: 'About', icon: 'bi-info-circle', path: '/about' },
  { name: 'Contact', icon: 'bi-envelope', path: '/contact' },
]

const isCollapsed = ref(true)

const settings = [
  { name: 'Settings', icon: 'mdi-cog', path: '/settings' },
]
</script>

<template>
  <div class="container">
    <nav class="navbar navbar-expand-lg mb-4 border-bottom">
      <nuxt-link
        :to="pagerouts[0].path"
        class="navbar-brand d-flex align-items-center text-decoration-none"
      >
        <img
          src="logo.png"
          class="bg-white rounded"
        >
      </nuxt-link>
      <button
        class="navbar-toggler border-0 shadow-none"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNavDropdown"
        aria-controls="navbarNavDropdown"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon" />
      </button>
      <div
        id="navbarNavDropdown" class="collapse navbar-collapse"
        :class="[{ show: !isCollapsed }]"
      >
        <ul class="navbar-nav ms-auto">
          <li v-for="routeItem in pagerouts " :key="routeItem.name" class="nav-item text-uppercase">
            <nuxt-link class="nav-link" :to="routeItem.path">
              <i :class="`bi ${routeItem.icon}`" />
              {{ routeItem.name }}
            </nuxt-link>
          </li>
        </ul>
        <!-- Right Side Buttons -->
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <nuxt-link
              class="btn btn-primary rounded-circle ms-2 d-flex align-items-center justify-content-center"
              to="/settings"
              style="width: 40px; height: 40px;"
            >
              <i class="mdi mdi-cog" />
            </nuxt-link>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>
