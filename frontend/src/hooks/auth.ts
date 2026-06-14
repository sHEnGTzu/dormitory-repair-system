import { useAuthStore } from '@/stores'

export function useAuth() {
  const authStore = useAuthStore()
  return Boolean(authStore.user.token)
}
