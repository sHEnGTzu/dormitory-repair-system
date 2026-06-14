import { baseHttp } from '@/api/request'

export function dormitoryPageApi(data: Api.Commom.PageDTO) {
  return baseHttp.request<Api.Commom.PageVO<Api.Dormitory.Dormitory>>({
    url: '/dormitory/list/page',
    method: 'post',
    data,
  })
}

export function dormitoryAddApi(data: Api.Dormitory.Dormitory) {
  return baseHttp.request<boolean>({
    url: '/dormitory/add',
    method: 'post',
    data,
  })
}

export function dormitoryEditApi(data: Api.Dormitory.Dormitory) {
  return baseHttp.request<boolean>({
    url: '/dormitory/edit',
    method: 'post',
    data,
  })
}

export function dormitoryDeleteApi(id: number) {
  return baseHttp.request<boolean>({
    url: '/dormitory/delete',
    method: 'post',
    data: { id },
  })
}

export function dormitoryAllApi() {
  return baseHttp.request<Api.Dormitory.Dormitory[]>({
    url: '/dormitory/list/all',
    method: 'post',
  })
}

export function dormitoryCountApi() {
  return baseHttp.request<number>({
    url: '/dormitory/count',
    method: 'post',
  })
}
