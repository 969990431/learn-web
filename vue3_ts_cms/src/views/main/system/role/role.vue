<template>
  <div class="role">
    <page-search :config="searchConfig" @reset="reset" @queryClick="queryClick"></page-search>
    <page-content :config="contentConfig" ref="contentRef" @newModal="newModalClick" @editModal="editModalClick"></page-content>
    <page-modal :modalConfigNameNameName="modalConfig" :otherInfos="otherInfos" ref="modalRef">
      <template #customSlot>
        <el-tree
          ref="treeRef"
          :data="allMenus"
          show-checkbox
          node-key="id"
          :props="{ children: 'children', label: 'name' }"
          @check="handleElTreeCheck"
        />
      </template>
    </page-modal>
  </div>
</template>

<script setup lang="ts">
import { contentConfig } from './config/content.config'
import { modalConfig } from './config/modal.config'
import { searchConfig } from './config/search.config'
import PageModal from '@/components/page-search/page-modal.vue'
import PageSearch from '@/components/page-search/page-search.vue'
import PageContent from '@/components/page-search/page-content.vue'
import usePageContent from '@/hooks/usePageContent'
import { usePageModal } from '@/hooks/usePageModal'
import { useInfoStore } from '@/store/system/info'
import { ref } from 'vue'
import { nextTick } from 'vue'
import { storeToRefs } from 'pinia'
import type { ElTree } from 'element-plus'
import { menusToIds } from '@/utils/map-menus'

const { contentRef, reset, queryClick } = usePageContent()
const { modalRef, newModalClick, editModalClick } = usePageModal(editModalDataCallback, newModalDataCallBack)

const allMenus = storeToRefs(useInfoStore()).allMenus
const otherInfos = ref({})
function handleElTreeCheck(data1: any, data2: any) {
  const menuList = [...data2.checkedKeys, ...data2.halfCheckedKeys]
  otherInfos.value = { menuList }
}

const treeRef = ref<InstanceType<typeof ElTree>>()
function editModalDataCallback(item: any) {
  const ids = menusToIds(item.menuList)
  //nextTick作用:第一次加载对话框,数据会在对话框dom挂载前传过去,此时还没有对话框,会不显示,nexttick是在dom更新完成后进行操作,promise.then执行其中的微任务,刚才出现的bug:即使写了nexttick也没用,是因为我把回调函数的调用,写在了visible前面,此时dom都还没初始化和挂载呢,nextTick才没用,必须是已经挂载并更新完成,才是nextTick里边执行的时机
  nextTick(()=>{
    treeRef.value?.setCheckedKeys(ids)
  })
}
function newModalDataCallBack() {
  console.log(123123)
  nextTick(()=> {
    treeRef.value?.setCheckedKeys([])
  })
}
</script>

<style lang="less" scoped>
.role {
}
</style>
