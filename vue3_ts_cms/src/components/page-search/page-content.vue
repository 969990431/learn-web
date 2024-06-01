<template>
  <div class="content">
    <div class="header">
      <span>{{ config.header.title }}</span>
      <el-button v-if="isCreate" type="primary" @click="newModalClick">{{ config.header.btnTitle }}</el-button>
    </div>
    <div class="table">
      <el-table :data="pageList" border>
        <template v-for="item in config.propsList" :key="item.label">
          <el-table-column align="center" :type="item.type" :label="item.label" :prop="item.prop" :width="item.width">
            <template v-if="item.type === 'handler'" #default="scope">
              <el-button v-if="isUpdate" icon="Edit" type="primary" size="small" text @click="editClick(scope.row)"> 编辑 </el-button>
              <el-button v-if="isDelete" icon="Delete" type="danger" size="small" text @click="deleteClick(scope.row.id)"> 删除 </el-button>
            </template>
            <template v-else-if="item.type === 'timer'" #default="scope">
              {{ formatUTC(scope.row[item.prop]) }}
            </template>
            <template v-else-if="item.type === 'custom'" #default="">
              <slot :name="item.slotName" :bindItem="item" :aaa="11111"></slot>
            </template>
          </el-table-column>
        </template>
        <!-- <el-table-column align="center" type="selection" width="50"></el-table-column>
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
        </el-table-column> -->
      </el-table>
    </div>
    <div class="footer">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="pageSize"
        :page-sizes="[5, 10, 20]"
        layout="total, sizes, prev, pager, next, jumper"
        :total="pageTotalCount"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { useSystemStore } from '@/store/system/system'
import { formatUTC } from '@/utils/format'
import { storeToRefs } from 'pinia'
import { ref } from 'vue'
import PageModal from './page-modal.vue'
import useLoginStore from '@/store/login/login'

// import NewUserModal from './new-user-modal.vue'
interface IConfig {
  config: {
    pageName: string
    header: {
      title: string
      btnTitle: string
    }
    propsList: any
  }
}
const props = defineProps<IConfig>()

const systemStore = useSystemStore()
const { pageList, pageTotalCount } = storeToRefs(systemStore)
const currentPage = ref(1)
const pageSize = ref(10)
systemStore.$onAction((params) => {
  params.after = () => {
    if (params.name === 'addPageItem' || params.name === 'deletePageItem' || params.name === 'editPageItem') {
      currentPage.value = 1
    }
  }
})
const loginStore = useLoginStore()
const { permisions } = loginStore
const isDelete = !!(permisions.find(item=>item.includes(`${props.config.pageName}:delete`)))
const isCreate = Boolean(permisions.find(item=>item.includes(`${props.config.pageName}:create`)))
const isUpdate = Boolean(permisions.find(item=>item.includes(`${props.config.pageName}:update`)))
const isQueryData = Boolean(permisions.find(item=>item.includes(`${props.config.pageName}:query`)))

getUserData()
function handleSizeChange() {
  getUserData()
}
function handleCurrentChange() {
  getUserData()
}

function getUserData(formData: any = {}, isQuery: boolean = false) {
  if(!isQueryData) return
  console.log(isQuery)
  if (isQuery) {
    currentPage.value = 1
    pageSize.value = 10
  }
  const params = { size: pageSize.value, offset: (currentPage.value - 1) * pageSize.value }

  systemStore.getPageList(props.config.pageName, { ...params, ...formData })
}
interface IRes {
  code: number
  data: string
}

function deleteClick(id: number) {
  systemStore.deletePageItem(props.config.pageName, id)
}
const emits = defineEmits(['newModal', 'editModal'])
function newModalClick() {
  // modalRef.value.setVisible()
  emits('newModal')
}
function editClick(item: any) {
  // modalRef.value.setVisible(true, item)
  emits('editModal', item)
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
    margin-right: 10px;
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
