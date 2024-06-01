import jkRequest from '@/service'

export function getRolesInfo() {
  return jkRequest.post({
    url: '/role/list'
  })
}

export function getDepartMentInfo() {
  return jkRequest.post({
    url: '/department/list'
  })
}

export function getAllMenuList() {
return jkRequest.post({
  url:'/menu/list'
})
}