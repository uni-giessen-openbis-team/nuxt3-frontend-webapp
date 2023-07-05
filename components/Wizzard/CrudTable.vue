<script setup lang="ts">
const { modelValue } = defineModels<{ modelValue: Array<String> }>()

const addItem = () => {
  modelValue.value.push('')
}

const deleteItem = (index: Number) => {
  modelValue.value.splice(index, 1)
}
</script>

<template>
  <div>
    <table>
      <tr v-for="(item, index) in modelValue" :key="index">
        <td>
          <input v-model="modelValue[index]" type="text">
          <button @click="addItem" />
          <button @click="() => deleteItem(index)">
            Delete
          </button>
        </td>
      </tr>
      <button @click="addItem">
        add
      </button>
    </table>
  </div>
  <div>
    <pre>
      {{ modelValue }}
    </pre>
  </div>
</template>
