import {
  addPageData,
  deletPageById,
  deleteUserById,
  editPageData,
  editUser,
  getUserList,
  newUser,
  postPageListData
} from '@/service/modules/system/system'
import { defineStore } from 'pinia'
import { useInfoStore } from './info'

export interface user {
  id: number
  name: string
  realname: string
  cellphone: number
  enable: number
  departmentId: number
  roleId: number
  createAt: string
  updateAt: string
}
export interface systemState {
  userList: user[]
  totalCount: number
  pageList: []
  pageTotalCount: number
}
export const useSystemStore = defineStore('system', {
  state: (): systemState => ({
    userList: [],
    totalCount: 0,
    pageList: [],
    pageTotalCount: 0
  }),
  actions: {
    async fetchUserList(params: any) {
      const res = await getUserList(params)
      this.userList = res.data.list
      this.totalCount = res.data.totalCount
    },

    deleteUserById(id: number) {
      return deleteUserById(id)
    },

    async addNewUser(userInfo: any) {
      const res = await newUser(userInfo)
      this.fetchUserList({ size: 10, offset: 0 })
    },

    async editUser(id: number, userInfo: any) {
      const res = await editUser(id, userInfo)
      this.fetchUserList({ size: 10, offset: 0 })
    },
    //
    async getPageList(pageName: string, queryInfo: any) {
      const res = await postPageListData(pageName, queryInfo)
      const { list, totalCount } = res.data
      this.pageList = list
      this.pageTotalCount = totalCount
      const infoStore = useInfoStore()
      infoStore.fetchInfoData()
    },
    async deletePageItem(pageName: string, id: number) {
      return deletPageById(pageName, id).then((res)=> {
        this.getPageList(pageName, { size: 10, offset: 0 })
        const infoStore = useInfoStore()
      infoStore.fetchInfoData()
      })
    },
    async editPageItem(pageName: string, id: number, userInfo: any) {
      const res = await editPageData(pageName, id, userInfo)
      this.getPageList(pageName, { size: 10, offset: 0 })
      const infoStore = useInfoStore()
      infoStore.fetchInfoData()
    },
    async addPageItem(pageName: string, userInfo: any) {
      const res = await addPageData(pageName, userInfo)
      this.getPageList(pageName, { size: 10, offset: 0 })
      const infoStore = useInfoStore()
      infoStore.fetchInfoData()
    }
  }
})
