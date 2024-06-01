<template>
  <div class="login-panel animate__animated animate__bounce" >
    <h2>后台管理系统</h2>
    <div class="tabs">
      <el-tabs stretch type="border-card" v-model="modelValue">
        <el-tab-pane name="account">
          <template #label>
            <div class="label">
              <el-icon>
                <UserFilled />
              </el-icon>
              <span class="text">账号登录</span>

            </div>
          </template>
          <panel-account ref="accountRef"/>
        </el-tab-pane>
        <el-tab-pane name="phone">
          <template #label>
            <div class="label">
              <el-icon>
                <Iphone />
              </el-icon>
              <span class="text">手机登录</span>
            </div>
          </template>
          <panel-phone />
        </el-tab-pane>
      </el-tabs>
    </div>
    <div class="controls">
      <el-checkbox v-model="isRemPwd" label="记住密码"></el-checkbox>
      <el-link type="primary">忘记密码</el-link>
    </div>
    <el-button class="login-btn" type="primary" @click="loginClick">立即登录</el-button>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PanelAccount from './panel-account.vue';
import PanelPhone from './panel-phone.vue';
import { localCache } from '@/utils/cache';

const isRemPwd = ref<boolean>(localCache.getBool('isRemPwd') ?? false)
const modelValue = ref<string>("account")
const accountRef = ref<InstanceType<typeof PanelAccount>>()
const loginClick = () => {
  console.log(modelValue.value === "phone" ? "手机登录" : "账户登录")
  accountRef.value?.loginAction(isRemPwd.value)
}

watch(isRemPwd, (newvalue)=> {
  localCache.setBool('isRemPwd', newvalue)
})
</script>

<style lang="less" scoped>
.login-panel {
  // background-color: salmon;
  width: 350px;
  margin-bottom: 150px;

  h2 {
    text-align: center;
    margin-top: 20px;
  }

  .tabs {
    .label {
      display: flex;
      align-items: center;

      .text {
        margin-left: 10px;

      }
    }
  }

  .controls {
    display: flex;
    align-items: center;
    justify-content: space-between;

  }

  .login-btn {
    width: 100%;
    margin-top: 10px;
    height: 40px;
  }
}
</style>
