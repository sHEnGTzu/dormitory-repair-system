<template>
  <NCard>
    <NButton type="primary" @click="handleAdd">
      <template #icon>
        <SvgIcon icon="mdi:plus" />
      </template>
      添加宿舍
    </NButton>
    <NDataTable
      class="mt-4"
      :columns="columns"
      :data="tableData"
      :loading="loading"
      remote
      :pagination="pagination"
      :scroll-x="700"
    />
    <NModal v-model:show="showModal" :title="isEdit ? '编辑宿舍' : '添加宿舍'" preset="card" style="width: 480px">
      <NForm :model="form" ref="formRef" :rules="rules" label-placement="left" label-width="80" size="large">
        <NFormItem label="宿舍楼" path="building">
          <NInput v-model:value="form.building" placeholder="请输入宿舍楼" />
        </NFormItem>
        <NFormItem label="楼层" path="floorNum">
          <NInputNumber v-model:value="form.floorNum" placeholder="请输入楼层" class="w-full" :min="1" />
        </NFormItem>
        <NFormItem label="房间号" path="roomNum">
          <NInput v-model:value="form.roomNum" placeholder="请输入房间号" />
        </NFormItem>
        
      </NForm>
      <template #footer>
        <NSpace justify="end">
          <NButton @click="showModal = false">取消</NButton>
          <NButton type="primary" :loading="submitting" @click="handleSubmit">确认</NButton>
        </NSpace>
      </template>
    </NModal>
  </NCard>
</template>

<script setup lang="tsx">
import { type DataTableColumns, NButton, NSpace, type FormInst, type FormRules, NInputNumber } from 'naive-ui'
import { dormitoryPageApi, dormitoryAddApi, dormitoryEditApi, dormitoryDeleteApi } from '@/api/dormitory'
import { useAuthStore } from '@/stores'
import { to } from 'await-to-js'

const authStore = useAuthStore()
const router = useRouter()
// 非管理员跳转首页
if (authStore.user.role !== '管理员') {
  window.$message.warning('仅管理员可访问宿舍管理')
  router.replace('/home')
}

const loading = ref(false)
const submitting = ref(false)
const tableData = ref<Api.Dormitory.Dormitory[]>([])
const showModal = ref(false)
const isEdit = ref(false)
const formRef = ref<FormInst | null>(null)

const initForm = () => ({
  id: 0,
  building: '',
  floorNum: 1,
  roomNum: '',
})
const form = reactive<Api.Dormitory.Dormitory>(initForm())

const rules: FormRules = {
  building: { required: true, message: '请输入宿舍楼', trigger: 'blur' },
  floorNum: { required: true, type: 'number', message: '请输入楼层', trigger: 'blur' },
  roomNum: { required: true, message: '请输入房间号', trigger: 'blur' },
}

const columns: DataTableColumns<Api.Dormitory.Dormitory> = [
  { title: '宿舍楼', key: 'building', width: 120 },
  { title: '楼层', key: 'floorNum', width: 80 },
  { title: '房间号', key: 'roomNum', width: 120 },
  {
    title: '操作',
    key: 'operation',
    width: 200,
    fixed: 'right',
    render(row) {
      return (
        <NSpace>
          <NButton type="primary" size="small" onClick={() => handleEdit(row)}>编辑</NButton>
          <NButton type="error" size="small" onClick={() => handleDelete(row)}>删除</NButton>
        </NSpace>
      )
    },
  },
]

const pagination = reactive({
  page: 1,
  pageSize: 10,
  itemCount: 0,
  onChange: (page: number) => {
    pagination.page = page
    getPageList()
  },
})

async function getPageList() {
  loading.value = true
  const [err, data] = await to(dormitoryPageApi({ current: pagination.page, size: pagination.pageSize }))
  loading.value = false
  if (err) {
    tableData.value = []
    return
  }
  tableData.value = data.records
  pagination.itemCount = data.total
}

getPageList()

function resetForm() {
  Object.assign(form, initForm())
}

function handleAdd() {
  isEdit.value = false
  resetForm()
  showModal.value = true
}

function handleEdit(row: Api.Dormitory.Dormitory) {
  isEdit.value = true
  Object.assign(form, row)
  showModal.value = true
}

async function handleSubmit() {
  submitting.value = true
  const [err] = await to(formRef.value!.validate())
  if (err) {
    submitting.value = false
    return
  }
  const api = isEdit.value ? dormitoryEditApi(form) : dormitoryAddApi(form)
  const [submitErr] = await to(api)
  submitting.value = false
  if (submitErr) return
  window.$message.success(isEdit.value ? '修改成功' : '添加成功')
  showModal.value = false
  getPageList()
}

function handleDelete(row: Api.Dormitory.Dormitory) {
  const dialogInstance = window.$dialog.warning({
    title: '温馨提示',
    content: `确定要删除 ${row.building} ${row.roomNum} 的宿舍信息吗？`,
    positiveText: '确定',
    negativeText: '取消',
    onPositiveClick: async () => {
      dialogInstance.loading = true
      const [err] = await to(dormitoryDeleteApi(row.id))
      dialogInstance.loading = false
      if (err) return false
      window.$message.success('删除成功')
      getPageList()
      return true
    },
  })
}
</script>

<style scoped></style>
