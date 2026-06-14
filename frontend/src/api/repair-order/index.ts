import { baseHttp } from '@/api/request'

export function repairOrderPageApi(data: Api.Commom.PageDTO) {
  return baseHttp.request<Api.Commom.PageVO<Api.RepairOrder.RepairOrder>>({
    url: '/repair-order/list/page',
    method: 'post',
    data,
  })
}

export function repairOrderAddApi(data: Api.RepairOrder.RepairOrder) {
  return baseHttp.request<boolean>({
    url: '/repair-order/add',
    method: 'post',
    data,
  })
}

export function repairOrderEditApi(data: Api.RepairOrder.RepairOrder) {
  return baseHttp.request<boolean>({
    url: '/repair-order/edit',
    method: 'post',
    data,
  })
}

export function repairOrderDeleteApi(id: number) {
  return baseHttp.request<boolean>({
    url: '/repair-order/delete',
    method: 'post',
    data: { id },
  })
}

export function repairOrderUpdateStatusApi(data: { id: number; status: string }) {
  return baseHttp.request<boolean>({
    url: '/repair-order/update-status',
    method: 'post',
    data,
  })
}

export function repairOrderCountApi() {
  return baseHttp.request<{ total: number; pending: number }>({
    url: '/repair-order/count',
    method: 'post',
  })
}
