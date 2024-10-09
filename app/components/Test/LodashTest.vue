<script setup>
const users = [
  { user: 'fred', age: 48 },
  { user: 'barney', age: 36 },
  { user: 'fred', age: 40 },
  { user: 'barney', age: 34 },
]

const test = useSortBy(users, ['user', 'age'])
</script>

<template>
  <p>{{ test }}</p>
</template>
