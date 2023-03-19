<script setup lang="ts">
/// / imports ////
import { onMounted, ref } from 'vue'

/// / types ////
export interface MyRow {
  [key: string]: any
}

/// / props ////
const props = defineProps({
  tableDefinition: {
    type: Object,
    required: true,
  },
  tableData: {
    type: Array as () => MyRow[],
    default: () => [],
  },
})

/// / emits ////
const emit = defineEmits(['update:table-data', 'update:modelValue'])

const rows = ref(props.tableData)

/// / lifecycle ////
onMounted(() => {
  addRow()
})

/// / methods ////
function addRow() {
  const newRow: MyRow = {}

  // Get values from the last row, if available
  const lastRow
    = rows.value.length > 0 ? rows.value[rows.value.length - 1] : null

  for (const column of props.tableDefinition.columns) {
    if (column.name === 'replicate' && lastRow)
      newRow[column.name] = lastRow[column.name] + 1
    else
      newRow[column.name] = lastRow ? lastRow[column.name] : ''
  }

  rows.value.push(newRow)
}

function removeRow(index: number) {
  rows.value.splice(index, 1)
}

function emitTableData() {
  emit('update:modelValue', rows.value)
}
</script>

<template>
  <div>
    <div class="mb-3">
      Here, you can generate a sample sheet for your data. The sample sheet is a
      table that contains information about your samples. The columns of the
      table are defined by the workflow. You can add and remove rows to the
      table.
    </div>
    <table class="table table-striped table-bordered">
      <thead>
        <tr>
          <th v-for="column in tableDefinition.columns" :key="column.name">
            {{ column.header }}
          </th>
          <th />
        </tr>
      </thead>
      <tbody>
        <tr v-for="(row, index) in rows" :key="index">
          <td v-for="column in tableDefinition.columns" :key="column.name">
            <input
              v-if="column.type === 'string' || column.type === 'file'"
              v-model="row[column.name]"
              type="text"
              :required="column.required"
              class="form-control"
              @input="emitTableData"
            >
            <input
              v-else-if="column.type === 'int'"
              v-model.number="row[column.name]"
              type="number"
              :required="column.required"
              :min="column.constraints?.interval?.min"
              class="form-control"
              @input="emitTableData"
            >
          </td>
          <td>
            <button
              class="btn btn-danger"
              :disabled="rows.length <= 1"
              @click="removeRow(index)"
            >
              Remove
            </button>
          </td>
        </tr>
      </tbody>
    </table>
    <button class="btn btn-primary" @click="addRow()">
      Add row
    </button>
  </div>
</template>

<style scoped>
.rounded-bottom {
  border-radius: 0 0 10px 10px;
  padding: 10px;
}

.light-blue {
  background-color: #e3f2fd4d;
}
</style>
