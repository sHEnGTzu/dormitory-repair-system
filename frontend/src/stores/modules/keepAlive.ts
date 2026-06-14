import { traverseRoutes } from '@/router/utils'
import { routes } from '@/router/routes'
import { useTabStore } from './tab'
export const useKeepAliveStore = defineStore('keepAlive', () => {
  const globalKeepAliveList = ref<RouteRecordName[]>([])

  const tabStore = useTabStore()

  const keepAliveList = computed(() => {
    return globalKeepAliveList.value.filter((item) => {
      return tabStore.tabsList.some((tab) => {
        return tab.name === item
      })
    })
  })
  function initKeepAliveData() {
    const list: RouteRecordName[] = []
    traverseRoutes(routes, (route) => {
      if (!route.meta?.keepAlive) return
      list.push(route.name as RouteRecordName)
    })
    globalKeepAliveList.value = list
  }

  return {
    keepAliveList,
    initKeepAliveData,
  }
})
