<template>
  <div class="content">
    <div class="header">
      <span>用户列表</span>
      <el-button type="primary" @click="newModalClick">新建用户</el-button>
    </div>
    <div class="table">
      <el-table :data="userList" border>
        <el-table-column align="center" type="selection" width="50"></el-table-column>
        <el-table-column align="center" type="index" label="序号" width="60"></el-table-column>

        <el-table-column align="center" prop="name" label="用户名" width="100"></el-table-column>
        <el-table-column align="center" prop="realname" label="真实姓名" width="100"></el-table-column>
        <el-table-column align="center" prop="cellphone" label="手机号码" width="130"></el-table-column>
        <el-table-column align="center" label="状态" width="90">
          <template #default="scope">
            <el-button size="small" plain :type="scope.row.enable === 1 ? 'primary' : 'danger'">{{ scope.row.enable ? '启用' : '禁用' }}</el-button>
          </template>
        </el-table-column>
        <el-table-column align="center" label="创建时间">
          <template #default="scope">
            <span>{{ formatUTC(scope.row.createAt) }}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" prop="updateAt" label="更新时间">
          <template #default="scope">
            <span>{{ formatUTC(scope.row.updateAt) }}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="操作" width="150">
          <template #default="scope">
            <el-button size="small" icon="Edit" type="primary" text @click="editClick(scope.row)">编辑</el-button>
            <el-button size="small" icon="delete" type="danger" text @click="deleteClick(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div class="footer">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[5, 10, 20]"
        layout="total, sizes, prev, pager, next, jumper"
        :total="totalCount"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>

    <new-user-modal ref="modalRef"></new-user-modal>
  </div>
</template>

<script setup lang="ts">
import { useSystemStore } from '@/store/system/system'
import { formatUTC } from '@/utils/format'
import { storeToRefs } from 'pinia'
import { ref } from 'vue'
import NewUserModal from './new-user-modal.vue'

const systemStore = useSystemStore()
const { userList, totalCount } = storeToRefs(systemStore)
const currentPage = ref(1)
const pageSize = ref(10)

getUserData()
function handleSizeChange() {
  getUserData()
}
function handleCurrentChange() {
  getUserData()
}

function getUserData(formData: any = {}, isQuery: boolean = false) {
  console.log(isQuery)
  if (isQuery) {
    currentPage.value = 1
    pageSize.value = 10
  }
  const params = { size: pageSize.value, offset: (currentPage.value - 1) * pageSize.value }

  systemStore.fetchUserList({ ...params, ...formData })
}
interface IRes {
  code: number
  data: string
}

function deleteClick(id: number) {
  systemStore.deleteUserById(id).then((res: IRes) => {
    if (res.code < 0) {
      ElMessage.error(res.data)
    }
    getUserData()
  })
}
const modalRef = ref()
function newModalClick() {
  modalRef.value.setVisible()
}
function editClick(item:any) {
  modalRef.value.setVisible(true,item)
}

defineExpose({
  getUserData
})
</script>

<style lang="less" scoped>
.content {
  padding: 20px;
  margin-top: 20px;
  background-color: white;
  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    span {
      font-weight: bold;
    }
  }
  .table {
    margin-top: 10px;
  }
  .el-button {
    margin: 0;
  }
  .footer {
    .el-pagination {
      // display: flex;
      justify-content: flex-end;
      margin-top: 10px;
    }
  }
}
</style>
