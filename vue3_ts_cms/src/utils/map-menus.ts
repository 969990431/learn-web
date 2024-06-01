import type { RouteRecordRaw } from 'vue-router'

function loadLocalRoutes() {
  const localRoutes: RouteRecordRaw[] = []
  const files: Record<string, any> = import.meta.glob('../router/**/*.ts', {
    eager: true
  })
  for (const key in files) {
    localRoutes.push(files[key].default)
  }

  return localRoutes
}

export let firstUrl: any

export function mapMenusToRoutes(userMenus: any) {
  const localRoutes = loadLocalRoutes()
  const routes: RouteRecordRaw[] = []
  for (const menu of userMenus) {
    for (const submenu of menu.children) {
      const route = localRoutes.find((item) => item.path === submenu.url)
      if (route) {
        // 这里coderwhy的判断似乎有问题,既然都在submenu里面了,肯定是有权限的,没权限接口是不会返回的
        routes.push({ path: menu.url, redirect: menu.children[0].url })
      }
      if (route) routes.push(route)
      if (route && !firstUrl) {
        firstUrl = submenu.url
      }
    }
  }
  return routes
}
/*  */
export function mapPathToMenu(path: string, menus: any[]) {
  for (const menu of menus) {
    for (const submenu of menu.children) {
      if (path === submenu.url) {
        return submenu
      }
    }
  }
}

interface Crumb {
  name: string
  path: string
}
export function mapCrumbPathsToMenu(path: string, menus: any[]) {
  const CrumbPaths: Crumb[] = []
  for (const menu of menus) {
    for (const submenu of menu.children) {
      if (path === submenu.url) {
        CrumbPaths.push({ name: menu.name, path: menu.url })
        CrumbPaths.push({ name: submenu.name, path: submenu.url })
      }
    }
  }
  return CrumbPaths
}

export function menusToIds(menu: any[]) {
  const ids: any[] = []
  recurrence(menu)
  function recurrence(menus: any[]) {
    for (const item of menus) {
      if (item.children) {
        recurrence(item.children)
      } else {
        ids.push(item.id)
      }
    }
  }

  return ids
}

export function menusToPemisions(menu: any[]) {
  const permisions: any[] = []
  recurrence(menu)
  function recurrence(menus: any[]) {
    for (const item of menus) {
      if (item.type === 3) {
        permisions.push(item.permission)
      } else {
        recurrence(item.children ?? [])
      }
    }
  }
  return permisions
}
