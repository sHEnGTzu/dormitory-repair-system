import { useAuthStore, useMenuStore, useTabStore, useKeepAliveStore } from '@/stores'
import { to as awaitTo } from 'await-to-js'
import type { Router } from 'vue-router'

export function setupGlobalRouterGuard(router: Router) {
  const authStore = useAuthStore()
  const menuStore = useMenuStore()
  const tabStore = useTabStore()
  const keepAliveStore = useKeepAliveStore()

  router.beforeEach(async (to) => {
    window.$loadingBar?.start()

    if (to.meta.constant) {
      return true
    }

    const isLogin = Boolean(authStore.user.token)
    const isUserDetail = Boolean(authStore.user.id)

    if (to.path === '/login') {
      if (isLogin) return '/'
      // 退出登录后跳转登录页，清空所有卡片
      tabStore.clearTabsAction()
      sessionStorage.clear()
      return true
    }

    if (!isLogin) {
      return '/login'
    }

    if (isLogin && !isUserDetail) {
      const [err] = await awaitTo(authStore.authDetailAction())
      if (err) {
        authStore.reset()
        return '/login'
      }
      menuStore.generateMenus()
      tabStore.initTabs()
      keepAliveStore.initKeepAliveData()
    }

    return true
  })

  router.afterEach(() => {
    window.$loadingBar?.finish()
  })

  router.onError(() => {
    window.$loadingBar?.error()
  })
}
