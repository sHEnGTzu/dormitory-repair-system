<template>
  <div class="relative overflow-hidden bg-primary-100 h-screen dark:bg-primary-900">
    <NCard class="absolute-center z-1 max-w-400px w-[90%]" size="large" :bordered="false" round hoverable>
      <div class="flex-center text-2xl text-primary">
        <ThemeControl />
      </div>

      <div class="mt-4 flex-center gap-4 text-primary">
        <SvgIcon local-icon="i-local-logo" class="text-6xl text-primary"></SvgIcon>
        <div class="text-3xl">{{ title }}</div>
      </div>

      <div v-if="!isRegisterMode" class="mt-2 text-center text-sm text-gray-500">
        宿舍报修管理系统
      </div>

      <NForm :model="formData" ref="formRef" :rules="rules" label-placement="left" label-width="auto" size="large" class="mt-6">
        <NFormItem path="username">
          <NInput
            v-model:value="formData.username"
            placeholder="请输入用户名"
            clearable
            :theme-overrides="{ borderRadius: '6px' }"
          />
        </NFormItem>
        <NFormItem path="password">
          <NInput
            v-model:value="formData.password"
            placeholder="请输入密码"
            clearable
            show-password-on="mousedown"
            type="password"
            :theme-overrides="{ borderRadius: '6px' }"
          />
        </NFormItem>
        <NFormItem label="姓名" path="realName" v-if="isRegisterMode">
          <NInput
            v-model:value="formData.realName"
            placeholder="请输入姓名"
            clearable
            :theme-overrides="{ borderRadius: '6px' }"
          />
        </NFormItem>
        <NFormItem path="confirmPassword" v-if="isRegisterMode">
          <NInput
            v-model:value="formData.confirmPassword"
            placeholder="请确认密码"
            clearable
            show-password-on="mousedown"
            type="password"
            :theme-overrides="{ borderRadius: '6px' }"
          />
        </NFormItem>
        <NFormItem>
          <NButton v-if="!isRegisterMode" type="primary" :loading="loading" round block @click="handleLogin">登录</NButton>
          <NButton v-else type="primary" :loading="loading" round block @click="handleRegister">注册</NButton>
        </NFormItem>
      </NForm>

      <div class="mt-2 text-center">
        <NButton text type="primary" @click="toggleMode">
          {{ isRegisterMode ? '已有账号？去登录' : '没有账号？去注册' }}
        </NButton>
      </div>
    </NCard>
    <TopWave />
    <BottomWave />
    <FooterInfo />
  </div>
</template>

<script setup lang="ts">
import { to } from 'await-to-js'
import { useAuthStore } from '@/stores'
import { useLoading } from '@/hooks/loading'
import { authRegisterApi } from '@/api/common/auth'
import type { FormInst, FormRules } from 'naive-ui'
import BottomWave from './components/BottomWave.vue'
import TopWave from './components/TopWave.vue'
import ThemeControl from '@/layouts/components/common/ThemeControl.vue'
import FooterInfo from './components/FooterInfo.vue'
const title = import.meta.env.VITE_APP_TITLE

const isRegisterMode = ref(false)

const formData = reactive({
  username: '',
  password: '',
  realName: '',
  confirmPassword: '',
})
const formRef = useTemplateRef<FormInst>('formRef')
const rules = computed<FormRules>(() => {
  const base: FormRules = {
    username: {
      required: true,
      trigger: ['input', 'blur'],
      message: '请输入用户名',
    },
    password: {
      required: true,
      trigger: ['input', 'blur'],
      message: '请输入密码',
    },
  }
  if (isRegisterMode.value) {
    base.realName = {
      required: true,
      trigger: ['input', 'blur'],
      message: '请输入姓名',
    }
    base.confirmPassword = {
      required: true,
      trigger: ['input', 'blur'],
      validator: (_rule, value) => value === formData.password,
      message: '两次输入的密码不一致',
    }
  }
  return base
})

const authStore = useAuthStore()
const { loading, startLoading, endLoading } = useLoading()

const route = useRoute()
const router = useRouter()
const redirect = route.query.redirect ? decodeURIComponent(route.query.redirect as string) : undefined

function toggleMode() {
  isRegisterMode.value = !isRegisterMode.value
  formData.username = ''
  formData.password = ''
  formData.realName = ''
  formData.confirmPassword = ''
}

async function handleLogin() {
  startLoading()
  const [err] = await to(formRef.value!.validate())
  if (err) {
    endLoading()
    return
  }
  const [loginErr] = await to(authStore.authLoginAction({ username: formData.username, password: formData.password }))
  if (loginErr) {
    endLoading()
    return
  }
  window.$message.success('登录成功')
  router.replace(redirect || '/')
}

async function handleRegister() {
  startLoading()
  const [err] = await to(formRef.value!.validate())
  if (err) {
    endLoading()
    return
  }
  const [registerErr] = await to(authRegisterApi({ username: formData.username, password: formData.password, realName: formData.realName }))
  if (registerErr) {
    endLoading()
    return
  }
  window.$message.success('注册成功，请登录')
  isRegisterMode.value = false
  formData.password = ''
  endLoading()
}
</script>

<style scoped></style>
