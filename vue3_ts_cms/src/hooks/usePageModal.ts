import PageModal from '@/components/page-search/page-modal.vue'
import { ref } from 'vue'

export function usePageModal(editModalDataCallback?:any, newModalDataCallBack?:any) {
  const modalRef = ref<InstanceType<typeof PageModal>>()
  function newModalClick() {
    modalRef.value?.setVisible()
    if(newModalDataCallBack) {
      newModalDataCallBack()
    }
  }
  function editModalClick(item: any) {
    modalRef.value?.setVisible(true, item)
    if(editModalDataCallback) {
      editModalDataCallback(item)
    }
  }
  return { modalRef, newModalClick, editModalClick }
}
