import { baseHttp } from '@/api/request'

export function authRegisterApi(data: { username: string; password: string; realName?: string }) {
  return baseHttp.request<null>({
    url: '/auth/register',
    method: 'POST',
    data,
  })
}

export function authLoginApi(data: { username: string; password: string }) {
  return baseHttp.request<Api.Auth.LoginVO>({
    url: '/auth/login',
    method: 'POST',
    data,
  })
}

export function authDetailApi() {
  return baseHttp.request<Api.Auth.DetailVO>({
    url: '/auth/detail',
    method: 'post',
  })
}

export function authLoginOutApi() {
  return baseHttp.request<boolean>({
    url: '/auth/logout',
    method: 'post',
  })
}

export function userDetailApi() {
  return baseHttp.request<Api.Auth.DetailVO>({
    url: '/user/detail',
    method: 'post',
  })
}

export function userEditApi(data: { realName?: string; phone?: string }) {
  return baseHttp.request<null>({
    url: '/user/edit',
    method: 'post',
    data,
  })
}
