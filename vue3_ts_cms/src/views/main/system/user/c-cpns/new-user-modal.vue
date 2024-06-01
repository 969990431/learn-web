<template>
  <div class="modal">
    <el-dialog :model="formData" v-model="isVisible" :title="isEditUser ? '编辑用户' : '新建用户'" width="500" center>
      <el-form>
        <el-form-item label="用户名" label-width="70" prop="name">
          <el-input placeholder="输入用户名" v-model="formData.name"></el-input>
        </el-form-item>
        <el-form-item label="真实姓名" label-width="70" prop="realname">
          <el-input placeholder="输入真实姓名" v-model="formData.realname"></el-input>
        </el-form-item>
        <el-form-item v-if="!isEditUser" label="密码" label-width="70" prop="password">
          <el-input placeholder="输入密码" type="password" show-password v-model="formData.password"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" label-width="70" prop="cellphone">
          <el-input placeholder="输入手机号" v-model="formData.cellphone"></el-input>
        </el-form-item>
        <el-form-item label="选择角色" label-width="70" prop="roleId">
          <el-select placeholder="请选择角色" v-model="formData.roleId">
            <template v-for="item in roles" :key="item.id">
              <el-option :label="item.name" :value="item.id"> </el-option>
            </template>
          </el-select>
        </el-form-item>
        <el-form-item label="选择部门" label-width="70" prop="departmentId">
          <el-select placeholder="请选择部门" v-model="formData.departmentId">
            <template v-for="item in departments" :key="item.id"> <el-option :label="item.name" :value="item.id"> </el-option> </template
          ></el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="isVisible = false">取消</el-button>
          <el-button type="primary" @click="confirmClick"> 确定 </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { useInfoStore } from '@/store/system/info'
import { useSystemStore } from '@/store/system/system'
import { storeToRefs } from 'pinia'
import { ref } from 'vue'
const formData = ref({
  name: '',
  realname: '',
  password: '',
  cellphone: '',
  roleId: '',
  departmentId: ''
})
const isEditUser = ref(false)
const isVisible = ref(false)
let editItem: any = {}
// 此处用函数不用属性,目的是为了方便事件拦截
function setVisible(isEdit: boolean = false, item?: any) {
  isVisible.value = true
  isEditUser.value = isEdit
  editItem = item
  if (item && isEdit) {
    for (const key in formData.value) {
      formData.value[key] = item[key]
    }
  } else {
    for (const key in formData.value) {
      formData.value[key] = ''
    }
  }
}
defineExpose({
  setVisible
})
const infoStore = storeToRefs(useInfoStore())
const { roles, departments } = infoStore
const systemStore = useSystemStore()

function confirmClick() {
  if (!isEditUser.value) {
    systemStore.addNewUser(formData.value).then(() => {
      isVisible.value = false
    })
  } else {
    systemStore.editUser(editItem.id, formData.value).then(() => {
      isVisible.value = false
    })
  }
}
</script>

<style lang="less" scoped>
.modal {
  .el-form {
    padding: 40px;
  }
  .dialog-footer {
    display: flex;
    justify-content: center;
  }
}
</style>
