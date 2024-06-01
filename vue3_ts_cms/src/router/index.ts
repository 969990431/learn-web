import { TOKEN } from '@/global/constants'
import { localCache } from '@/utils/cache'
import { firstUrl } from '@/utils/map-menus'
import { createRouter, createWebHashHistory } from 'vue-router'

const router = createRouter({
  history: createWebHashHistory(),
  routes: [
    {
      path: '/',
      redirect: '/main'
    },
    {
      path: '/login',
      component: () => import('../views/login/login.vue')
    },
    {
      path: '/main',
      name: 'main',
      // children:[],
      component: () => import('../views/main/main.vue')
    },
    {
      path: '/:pathMatch(.*)',
      component: () => import('../views/not-found/not-found.vue')
    }
  ]
})

router.beforeEach((to, from) => {
  const token = localCache.getCache(TOKEN)
  if (to.path === '/main' && !token) {
    return '/login'
  }
  if (to.path === '/main') {
    return firstUrl
  }
})
export default router
