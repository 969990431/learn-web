<template>
  <div class="header">
    <div class="left">
      <el-icon @click="iconClick">
        <component class="icon" :is="isFold ? 'expand' : 'fold'"></component>
      </el-icon>
      <el-breadcrumb separator="/">
        <template v-for="path in paths" :key="path.name">
          <el-breadcrumb-item :to="path.path"> {{ path.name }}</el-breadcrumb-item>
        </template>
      </el-breadcrumb>
    </div>

    <header-info />
  </div>
</template>

<script setup lang="ts">
import { mapCrumbPathsToMenu } from '@/utils/map-menus'
import HeaderInfo from '../main-header/header-info.vue'
import { computed, ref } from 'vue'
import { useRoute } from 'vue-router'
import useLoginStore from '@/store/login/login'

const isFold = ref(false)
const emits = defineEmits(['clickFold'])
const iconClick = () => {
  isFold.value = !isFold.value
  emits('clickFold', isFold.value)
}
const route = useRoute()
const loginStore = useLoginStore()
const paths = computed(() => {
  return mapCrumbPathsToMenu(route.path, loginStore.userMenu)
})
</script>

<style lang="less" scoped>
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 5px;
  .left {
    display: flex;
    align-items: center;
    .el-icon {
      width: 30px;
      height: 30px;
      .icon {
        width: 30px;
        height: 30px;
        margin-right: 10px;
      }
    }
  }
}
</style>
