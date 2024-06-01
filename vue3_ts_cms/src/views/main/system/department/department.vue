<template>
  <div class="department">
    <page-search :config="searchConfig" @reset="reset" @queryClick="queryClick"></page-search>
    <page-content :config="contentConfig" ref="contentRef" @newModal="newModalClick" @editModal="editModalClick">
      <template #slot="hahah">
        <div>{{ hahah.aaa }}</div>
      </template>
      <template #slot1="bindProps">
        <div>{{ bindProps.bindItem.text }}</div>
      </template>
    </page-content>
    <page-modal ref="modalRef" :modalConfigNameNameName="hasSelectOptionConfig"></page-modal>
  </div>
</template>

<script setup lang="ts">
import PageSearch from '@/components/page-search/page-search.vue'
import { searchConfig } from './config/search.config'
import PageContent from '@/components/page-search/page-content.vue'
import { contentConfig } from './config/content.config'
import { computed, ref } from 'vue'
import { modalConfig } from './config/modal.config'
import PageModal from '@/components/page-search/page-modal.vue'
import { useInfoStore } from '@/store/system/info'
import usePageContent from '@/hooks/usePageContent'
import { usePageModal } from '@/hooks/usePageModal'

const { contentRef, reset, queryClick } = usePageContent()

// const contentRef = ref<InstanceType<typeof PageContent>>()
// function reset() {
//   contentRef.value?.getUserData()
// }
// function queryClick(formData: any) {
//   contentRef.value?.getUserData(formData, true)
// }

const { modalRef, newModalClick, editModalClick } = usePageModal()
// const modalRef = ref<InstanceType<typeof PageModal>>()
// function newModalClick() {
//   modalRef.value?.setVisible()
// }
// function editModalClick(item: any) {
//   modalRef.value?.setVisible(true, item)
// }

const hasSelectOptionConfig = computed(() => {
  const infoStore = useInfoStore()
  const departments = infoStore.departments.map((item) => {
    return { label: item.name, value: item.id }
  })
  modalConfig.formItems.forEach((item) => {
    if (item.prop === 'parentId') {
      item.options.push(...departments)
    }
  })
  // for (const item of modalConfig.formItems) {
  //   if (item.prop === 'parentId') {
  //     item.options?.push(...departments)
  //   }
  // }
  return modalConfig
})
</script>

<style lang="less" scoped>
.department {
}
</style>
