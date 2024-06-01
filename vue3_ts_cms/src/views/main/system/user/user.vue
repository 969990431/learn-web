<template>
  <div class="user">
    <user-header @queryClick="queryClick" @reset="reset"/>
    <user-content ref="contentRef" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import UserContent from './c-cpns/user-content.vue'
import UserHeader from './c-cpns/user-header.vue'
const contentRef = ref<InstanceType<typeof UserContent>>()
function queryClick(formData: any) {
  contentRef.value?.getUserData(formData,true)
}
const reset = ()=> {
  contentRef.value?.getUserData()
}
</script>

<style lang="less" scoped>
.user {
}
</style>
