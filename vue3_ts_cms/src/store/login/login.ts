import { getUserMenusByRoleId, requestLoginInfo, requestUser } from '@/service/login/login'
import { defineStore } from 'pinia'
import type { IAccount } from '@/types'
import { localCache } from '@/utils/cache'
import { mapMenusToRoutes, menusToPemisions } from '@/utils/map-menus'
import router from '@/router'
import { useInfoStore } from '../system/info'

interface ILoginState {
  id: number
  token: string
  name: string
  userInfo: any
  userMenu: any
  permisions: string[]
}
const TOKEN = 'token'
const useLoginStore = defineStore('loginStore', {
  state: (): ILoginState => ({
    id: -1,
    token: '',
    name: '',
    userInfo: {},
    userMenu: [],
    permisions: []
  }),
  actions: {
    async requestLoginInfoAction(account: IAccount) {
      const res = await requestLoginInfo(account)
      this.id = res.data.id
      this.token = res.data.token
      this.name = res.data.name

      localCache.setCache(TOKEN, res.data.token)

      const userInfo = await requestUser(res.data.id)
      this.userInfo = userInfo.data
      console.log(userInfo)
      localCache.setCache('userInfo', userInfo.data)

      const userMenu = await getUserMenusByRoleId(this.userInfo.role.id)
      console.log(userMenu)
      this.userMenu = userMenu.data
      localCache.setCache('userMenu', userMenu.data)
      this.permisions = menusToPemisions(this.userMenu)
      const routes = mapMenusToRoutes(userMenu.data)
      routes.forEach((item) => router.addRoute('main', item))

      this.loadRoleAndDepartMents()
    },

    loadLocalCacheAction() {
      const token = localCache.getCache(TOKEN)
      const userInfo = localCache.getCache('userInfo')
      const userMenu = localCache.getCache('userMenu')
      if (token && userInfo && userMenu) {
        this.token = token
        this.userInfo = userInfo
        this.userMenu = userMenu
        const routes = mapMenusToRoutes(userMenu)
        this.permisions = menusToPemisions(this.userMenu)
        routes.forEach((item) => router.addRoute('main', item))
      }
      this.loadRoleAndDepartMents()
    },

    loadRoleAndDepartMents() {
      const infoStore = useInfoStore()
      infoStore.fetchInfoData()
    }
  }
})

export default useLoginStore
