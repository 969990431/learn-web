import jkRequest from '..'
import type { IAccount } from '@/types';

export function requestLoginInfo(account: IAccount) {
  return jkRequest.post({
    url: '/login',
    data: account
  })
}

export function requestUser(id:number) {
  return jkRequest.get({
    url:`/users/${id}`
  })
}

export function getUserMenusByRoleId(id:number) {
  return jkRequest.get({
    url:`/role/${id}/menu`
  })
}
