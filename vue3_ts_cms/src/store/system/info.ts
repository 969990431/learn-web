import { getAllMenuList, getDepartMentInfo, getRolesInfo } from '@/service/modules/system/info'
import { defineStore } from 'pinia'

interface IInfos {
  roles:any[]
  departments:any[]
  allMenus:any[]
}
export const useInfoStore = defineStore('info', {
  state: ():IInfos => ({
    roles: [],
    departments: [],
    allMenus:[]
  }),
  actions: {
    async fetchInfoData() {
      const roles = await getRolesInfo()
      this.roles = roles.data?.list
      const departments = await getDepartMentInfo()
      this.departments = departments.data.list
      const allMenus = await getAllMenuList()
      this.allMenus = allMenus.data.list
    },


  }
})
