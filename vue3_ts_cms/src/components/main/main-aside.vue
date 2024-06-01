<template>
  <div class="aside">
    <div class="header">
      <img class="logo" src="@/assets/img/logo.svg" alt="" />
      <span v-show="!isFold" class="title">鸿源管理系统</span>
    </div>
    <el-menu :collapse="isFold" background-color="#001529" text-color="#b7bdb3" active-text-color="#fff" :default-active="defaultActive">
      <template v-for="item in userMenu" :key="item.id + ''">
        <el-sub-menu :index="item.id">
          <template #title>
            <el-icon>
              <component :is="item.icon.split('el-icon-')[1]"></component>
            </el-icon>
            <span>{{ item.name }}</span>
          </template>
          <template v-for="subItem in item.children" :key="subItem.id">
            <el-menu-item :index="subItem.id + ''" @click="handleClick(subItem)">
              <span>{{ subItem.name }}</span>
            </el-menu-item>
          </template>
        </el-sub-menu>
      </template>
    </el-menu>
  </div>
</template>

<script setup lang="ts">
import useLoginStore from '@/store/login/login'
import { mapPathToMenu } from '@/utils/map-menus'
import { computed, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
defineProps({
  isFold: {
    type: Boolean,
    default: false
  }
})
const loginStore = useLoginStore()
const { userMenu } = loginStore
const router = useRouter()
function handleClick(item: any) {
  router.push(item.url)
}
const route = useRoute()
const defaultActive = computed(() => {
  const currentMenu = mapPathToMenu(route.path, userMenu)
  return currentMenu.id + ''
})
</script>

<style lang="less" scoped>
.aside {
  background-color: #001529;

  .header {
    display: flex;
    padding: 10px 20px;

    .logo {
      width: 20px;
      height: 20px;
    }

    span {
      white-space: nowrap;
      margin-left: 10px;
      font-size: 16px;
      font-weight: 1000;
      color: #fff;
    }
  }
  .el-menu {
    border-right: none;
    // user-select: none;
    overflow: hidder;

    .el-menu-item.is-active {
      background-color: #0a60bd !important;
    }
  }
}
</style>
