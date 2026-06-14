<template>
  <NModal
    v-model:show="show"
    preset="dialog"
    positive-text="确定"
    negative-text="取消"
    title="修改密码"
    @positive-click="handleSubmit"
  >
    <NForm :model="formValue" :rules label-placement="left" ref="formRef" label-width="auto" class="py-8">
      <NFormItem path="oldPassword" label="旧密码">
        <NInput v-model:value="formValue.oldPassword" type="password" placeholder="请输入旧密码" />
      </NFormItem>
      <NFormItem path="newPassword" label="新密码">
        <NInput v-model:value="formValue.newPassword" type="password" placeholder="请输入新密码" />
      </NFormItem>
      <NFormItem path="confirmPassword" label="确认密码">
        <NInput v-model:value="formValue.confirmPassword" type="password" placeholder="请再次输入新密码" />
      </NFormItem>
    </NForm>
  </NModal>
</template>

<script setup lang="ts">
import { to } from 'await-to-js'
import type { FormInst, FormRules } from 'naive-ui'

const show = defineModel<boolean>('show', {
  required: true,
})

const rules: FormRules = {
  oldPassword: {
    required: true,
    message: '请输入旧密码',
    trigger: ['blur', 'input'],
  },
  newPassword: {
    required: true,
    message: '请输入新密码',
    trigger: ['blur', 'input'],
  },
  confirmPassword: {
    required: true,
    validator: (_, value: string) => {
      if (!value) {
        return new Error('请再次输入新密码')
      }
      if (value !== formValue.newPassword) {
        return new Error('两次输入的密码不一致')
      }
      return true
    },
    trigger: ['blur', 'input'],
  },
}

const formValue = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: '',
})
const formRef = useTemplateRef<FormInst>('formRef')

async function handleSubmit() {
  const [err] = await to(formRef.value!.validate())
  if (err) {
    return false
  }
  window.$message.warning('暂不支持修改密码')
  show.value = false
  return true
}
</script>

<style scoped></style>
