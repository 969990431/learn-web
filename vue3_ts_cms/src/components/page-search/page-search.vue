<template>
  <div class="header">
    <el-form label-width="80px" :model="formData" ref="headerRef">
      <el-row :gutter="20">
        <template v-for="item in config.formItems" :key="item.name">
          <el-col :span="8">
            <el-form-item :label="item.label" :prop="item.prop">
              <template v-if="item.type === 'input'">
                <el-input :placeholder="item.placeholder" v-model="formData[item.prop]"> </el-input>
              </template>
              <template v-if="item.type === 'picker'">
                <el-date-picker
                  type="daterange"
                  range-separator="到"
                  start-placeholder="开始时间"
                  end-placeholder="结束时间"
                  v-model="formData[item.prop]"
                >
                </el-date-picker>
              </template>
            </el-form-item>
          </el-col>
        </template>
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
// interface IItem {
//   type: string
//   label: string
//   name: string
//   placeholder?: string
// }
interface IProps {
  config: {
    pageName: string
    formItems: any[]
  }
}
const props = defineProps<IProps>()

const initialFormData = {}
for (const item of props.config.formItems) {
initialFormData[item.prop] = ''
}
const formData = ref(initialFormData)

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
