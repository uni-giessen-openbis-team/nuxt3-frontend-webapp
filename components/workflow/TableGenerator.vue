<script setup lang="ts">
/// / imports ////
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

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

// OpenBis setup
const store = useOpenBisStore()
const samples = ref([]) // This will hold your samples data
const selectedSample = ref(null)

onMounted(async () => {
  await store.loadV3API()
  samples.value = await store.searchSamples()
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
    <div>
      Here, you can generate a sample sheet for your data. The sample sheet is a
      table that contains information about your samples. The columns of the
      table are defined by the workflow. You can add and remove rows to the
      table.
    </div>
    <table style="width:100%">
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
            <v-autocomplete
              v-if="column.type === 'file'"
              v-model="row[column.name]"
              :items="samples"
              label="Select a sample"
              item-text="name"
              item-value="value"
              return-object
              single-line
              @change="emitTableData"
            />
            <v-text-field
              v-else-if="column.type === 'string'"
              v-model="row[column.name]"
              :required="column.required"
              single-line
              hide-details="auto"
              variant="underlined"
              @input="emitTableData"
            />
            <v-text-field
              v-else-if="column.type === 'int'"
              v-model.number="row[column.name]"
              type="number"
              :required="column.required"
              :min="column.constraints?.interval?.min"
              single-line
              hide-details="auto"
              variant="underlined"
              @input="emitTableData"
            />
          </td>
          <td>
            <v-btn
              color="error"
              :rounded="0"
              :disabled="rows.length <= 1"
              size="small"
              @click="removeRow(index)"
            >
              Remove
            </v-btn>
          </td>
        </tr>
      </tbody>
    </table>
    <v-btn @click="addRow()">
      Add row
    </v-btn>
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
