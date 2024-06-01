import jkRequest from '@/service'

export function getUserList(params:any) {
  return jkRequest.post({
    url: '/users/list',
    data: params
  })
}

export function deleteUserById(id:number) {
  return jkRequest.delete({
    url:`/users/${id}`
  })
}

export function newUser(newUserInfo:any) {
  return jkRequest.post({
    url:`/users`,
    data:newUserInfo
  })
}

export function editUser(id:number,newUserInfo:any) {
  return jkRequest.patch({
    url:`/users/${id}`,
    data:newUserInfo
  })
}

/* 针对页面的网络请求，增删改查 */
export function postPageListData(pageName: string, queryInfo: any) {
  return jkRequest.post({
    url: `/${pageName}/list`,
    data: queryInfo
  })
}

export function deletPageById(pageName: string, id: number) {
  return jkRequest.delete({
    url: `/${pageName}/${id}`
  })
}

export function addPageData(pageName: string, userInfo: any) {
  return jkRequest.post({
    url: `/${pageName}`,
    data: userInfo
  })
}

export function editPageData(pageName: string, id: number, userInfo: any) {
  return jkRequest.patch({
    url: `/${pageName}/${id}`,
    data: userInfo
  })
}

