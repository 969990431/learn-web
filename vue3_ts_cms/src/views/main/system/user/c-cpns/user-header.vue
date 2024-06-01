<template>
  <div class="header">
    <el-form label-width="80px" :model="formData" ref="headerRef">
      <el-row :gutter="20">
        <el-col :span="8"
          ><div class="grid-content ep-bg-purple" />
          <el-form-item label="用户名" prop="name">
            <el-input placeholder="请输入用户名" v-model="formData.name" />
          </el-form-item>
        </el-col>
        <el-col :span="8"
          ><div class="grid-content ep-bg-purple" />
          <el-form-item label="真实姓名" prop="realname"> <el-input placeholder="请输入真实姓名" v-model="formData.realname" /> </el-form-item
        ></el-col>
        <el-col :span="8"
          ><div class="grid-content ep-bg-purple" />
          <el-form-item label="手机号码" prop="cellphone"> <el-input placeholder="请输入手机号" v-model="formData.cellphone" /> </el-form-item
        ></el-col>
        <el-col :span="8"
          ><div class="grid-content ep-bg-purple" />
          <el-form-item label="状态" prop="enable">
            <el-select placeholder="请选择查询状态" style="width: 100%" v-model="formData.enable">
              <el-option label="启用" :value="1" />
              <el-option label="禁用" :value="0" /> </el-select></el-form-item
        ></el-col>
        <el-col :span="8"
          ><div class="grid-content ep-bg-purple" />
          <el-form-item label="创建时间" prop="createAt">
            <el-date-picker
              type="daterange"
              range-separator="到"
              start-placeholder="开始时间"
              end-placeholder="结束时间"
              v-model="formData.createAt"
            /> </el-form-item
        ></el-col>
      </el-row>
    </el-form>

    <div class="bottom">
      <el-button icon="Refresh" @click="resetClick">重置</el-button>
      <el-button type="primary" icon="Search" @click="searchClick">查询</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { ElForm } from 'element-plus'
import { ref } from 'vue'

const formData = ref({ name: '', realname: '', cellphone: '', enable: 1, createAt: '' })
const headerRef = ref<InstanceType<typeof ElForm>>()
const emits = defineEmits(['queryClick', 'reset'])
function resetClick() {
  headerRef.value?.resetFields()
  emits('reset')
}
function searchClick() {
  console.log(formData)
  emits('queryClick', formData.value)
}
</script>

<style lang="less" scoped>
.header {
  background-color: white;
  padding: 40px 40px 0 40px;
  border-radius: 10px;
  overflow: hidden;
  .el-col {
    margin-bottom: 30px;
  }
  .el-col:last-child {
    margin-bottom: 0;
  }
  .bottom {
    text-align: right;
    margin-bottom: 20px;
    .el-button {
      margin-left: 30px;
    }
  }
}
</style>
