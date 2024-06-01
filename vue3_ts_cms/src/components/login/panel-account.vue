<template>
  <div class="account">
    <el-form ref="formElRef" label-width="auto" :model="formLabelAlign" :rules="rules" status-icon>
      <el-form-item label="账号" prop="name">
        <el-input v-model="formLabelAlign.name" />
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="formLabelAlign.password" type="password" show-password />
      </el-form-item>

    </el-form>
  </div>
</template>

<script setup lang="ts">
import useLoginStore from '@/store/login/login';
import type { FormRules, ElForm } from 'element-plus';
import { reactive, ref } from 'vue';
import type { IAccount } from '@/types';
import { useRouter } from 'vue-router';
import { localCache } from '@/utils/cache';

const formLabelAlign = reactive<IAccount>({
  name: localCache.getCache('name') ?? '',
  password: localCache.getCache('password') ?? ''
})

const rules = reactive<FormRules>({
  name:
    [{ required: true, message: '请输入账号', trigger: 'blur' },
    { pattern: /^[0-9a-zA-Z]{0,9}$/, message: '请输入0-9位账号', trigger: 'change' },],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { pattern: /^[0-9a-zA-Z]{0,9}$/, message: '请输入0-9位密码', trigger: 'change' }
    // { pattern: /^(?=.*[a-zA-Z])(?=.*\d)[0-9a-zA-Z]{6,20}$/, message: '请输入6-20位数字与字母组合的密码', trigger: 'change' }
  ]

})

const formElRef = ref<InstanceType<typeof ElForm>>()
const loginStore = useLoginStore()
const router = useRouter()
const loginAction = (isRemPwd:boolean) => {
  formElRef.value?.validate((result) => {
    if (!result) {
      ElMessage.error('Oops,请输入正确的内容!')
    } else {
      loginStore.requestLoginInfoAction({ name: formLabelAlign.name, password: formLabelAlign.password }).then(() => {
        if (isRemPwd) {
          localCache.setCache('name', formLabelAlign.name)
          localCache.setCache('password', formLabelAlign.password)
        }else {
          localCache.removeCache('name')
          localCache.removeCache('password')
        }
        // localCache.setBool('isRemPwd', isRemPwd)
        router.push('/main')
      })
    }
  })
}

defineExpose({
  loginAction
})
</script>

<style lang="less" scoped>
.account {}
</style>
