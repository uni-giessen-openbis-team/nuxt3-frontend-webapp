<script setup>
const VARIBALE_TYPES = ['Categorical', 'Continuous']

class Variable {
  init(retitle) {
    this.title = retitle || ref('')
    this.conditions = ref('')
    this.variableType = ref('') // "Categorical", "Continuous"
    this.unit = ref('')
  }
}

species = new Variable()
</script>

<template>
  test
</template>
