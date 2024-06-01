<template>
  <div class="home">
    <el-container class="container">
      <el-aside class="aside" :width="isFold ? '60px' : '200px'">
        <main-aside :isFold="isFold"></main-aside>

      </el-aside>
      <el-container>
        <el-header class="header" height="40px">
          <main-header @clickFold="changeFoldStatus"></main-header>
        </el-header>
        <el-main class="main">
          <router-view></router-view>
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import MainAside from '@/components/main/main-aside.vue'
import MainHeader from '@/components/main/main-header.vue'
import MainMain from '@/components/main/main-main.vue'
import { ref } from 'vue'
const isFold = ref(false)
const changeFoldStatus = (flag: boolean) => {
  isFold.value = flag
}
// import { TOKEN } from '@/global/constants';
// import { localCache } from '@/utils/cache';
// import { useRouter } from 'vue-router';
// const router = useRouter()
// const loginout = () => {
//   if(!localCache.getBool('isRemPwd')) {

//     localCache.removeCache(TOKEN)
//     localCache.removeCache('name')
//     localCache.removeCache('password')
//   }
//   router.push('/login')
// }
</script>

<style lang="less" scoped>
.home {
  height: 100%;

  .container {
    height: 100%;

    .aside {
      background-color: #000;
      transition: width 0.3s ease;
    }

    .header {
      background-color: white;
    }

    .main {
      background-color: lightgray;
    }
  }
}
</style>
