import PageContent from '@/components/page-search/page-content.vue'
import { ref } from 'vue'

function usePageContent() {
  const contentRef = ref<InstanceType<typeof PageContent>>()
  function reset() {
    contentRef.value?.getUserData()
  }
  function queryClick(formData: any) {
    contentRef.value?.getUserData(formData, true)
  }

  return { contentRef, reset, queryClick }
}

export default usePageContent