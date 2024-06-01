<template>
  <div class="info">
    <el-icon class="icon" size="25px"><PieChart /></el-icon>
    <el-icon class="icon message" size="25px"
      ><Message />
      <div class="dot"></div
    ></el-icon>

    <el-dropdown>
      <span class="el-dropdown-link">
        <el-avatar class="avatar" :size="30" src="https://fuss10.elemecdn.com/e/5d/4a731a90594a4af544c0c25941171jpeg.jpeg" />
        {{ name }}
        <el-icon class="el-icon--right">
          <arrow-down />
        </el-icon>
      </span>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item @click="loginOutClick"
            ><el-icon><CircleClose /></el-icon><span>退出登录</span></el-dropdown-item
          >
          <el-dropdown-item divided
            ><el-icon><InfoFilled /></el-icon><span>个人信息</span></el-dropdown-item
          >
          <el-dropdown-item divided
            ><el-icon><Unlock /></el-icon><span>修改密码</span></el-dropdown-item
          >
        </el-dropdown-menu>
      </template>
    </el-dropdown>
  </div>
</template>

<script setup lang="ts">
import useLoginStore from '@/store/login/login'
import { localCache } from '@/utils/cache'
import { computed } from 'vue'
import { TOKEN } from '@/global/constants'
import { useRouter } from 'vue-router'

const loginStore = useLoginStore()
const name = computed(() => {
  return loginStore.userInfo.name
})

const router = useRouter()
const loginOutClick = () => {
  if (!localCache.getBool('isRemPwd')) {
    localCache.removeCache(TOKEN)
    localCache.removeCache('name')
    localCache.removeCache('password')
  } else {
    localCache.removeCache(TOKEN)
  }
  router.push('/login')
}
</script>

<style lang="less" scoped>
.info {
  .icon {
    margin-right: 10px;
  }
  .message {
    .dot {
      position: absolute;
      right: 0px;
      top: 0px;
      background-color: red;
      width: 6px;
      height: 6px;
      border-radius: 3px;
    }
  }
  .el-dropdown-link:focus {
    outline: none;
  }
  .el-dropdown-link {
    display: flex;
    align-items: center;
    justify-content: space-between;

    .avatar {
      margin-right: 10px;
    }
    .el-icon--right {
      margin-left: 10px;
    }
  }
}
</style>
