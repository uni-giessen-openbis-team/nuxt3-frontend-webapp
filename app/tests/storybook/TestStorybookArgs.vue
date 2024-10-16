<template>
    <div>
{{ props.test }}
    </div>
</template>

<script setup lang="ts">
const props = defineProps<{
    test: string
}>()


</script>

<style lang="scss" scoped>

</style>  