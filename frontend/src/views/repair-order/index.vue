<template>
  <NCard>
    <!-- 学生：显示「新增报修」按钮，管理员：显示「全部报修」标题 -->
    <div class="flex items-center justify-between">
      <NButton v-if="isStudent" type="primary" @click="handleAdd">
        <template #icon>
          <SvgIcon icon="mdi:plus" />
        </template>
        新增报修
      </NButton>
      <div v-else class="text-lg font-medium">全部报修单</div>
    </div>
    <NDataTable
      class="mt-4"
      :columns="columns"
      :data="tableData"
      :loading="loading"
      remote
      :pagination="pagination"
      :scroll-x="isStudent ? 800 : 1050"
    />

    <!-- 新增/编辑报修单弹窗（学生用） -->
    <NModal v-model:show="showModal" :title="isEdit ? '编辑报修单' : '新增报修单'" preset="card" style="width: 560px">
      <NForm :model="form" ref="formRef" :rules="formRules" label-placement="left" label-width="80" size="large">
        <NFormItem label="所属宿舍" path="dormitoryId" v-if="!isEdit">
          <NSelect
            v-model:value="form.dormitoryId"
            placeholder="请选择所属宿舍"
            :options="dormitoryOptions"
            :loading="dormLoading"
          />
        </NFormItem>
        <NFormItem label="报修标题" path="title">
          <NInput v-model:value="form.title" placeholder="请输入报修标题" />
        </NFormItem>
        <NFormItem label="故障类型" path="repairType">
          <NSelect
            v-model:value="form.repairType"
            placeholder="请选择故障类型"
            :options="repairTypeOptions"
          />
        </NFormItem>
        <NFormItem label="故障描述" path="description">
          <NInput v-model:value="form.description" placeholder="请描述故障情况" type="textarea" :rows="4" />
        </NFormItem>
      </NForm>
      <template #footer>
        <NSpace justify="end">
          <NButton @click="showModal = false">取消</NButton>
          <NButton type="primary" :loading="submitting" @click="handleSubmit">确认</NButton>
        </NSpace>
      </template>
    </NModal>

    <!-- 更新状态弹窗（管理员用） -->
    <NModal v-model:show="showStatusModal" title="更新报修状态" preset="card" style="width: 420px">
      <NForm :model="statusForm" ref="statusFormRef" :rules="statusRules" label-placement="left" label-width="80" size="large">
        <NFormItem label="当前状态">
          <NInput :value="statusForm.currentStatus" disabled />
        </NFormItem>
        <NFormItem label="新状态" path="status">
          <NSelect
            v-model:value="statusForm.status"
            placeholder="请选择新状态"
            :options="statusOptions"
          />
        </NFormItem>
      </NForm>
      <template #footer>
        <NSpace justify="end">
          <NButton @click="showStatusModal = false">取消</NButton>
          <NButton type="primary" :loading="statusSubmitting" @click="handleUpdateStatus">确认</NButton>
        </NSpace>
      </template>
    </NModal>
  </NCard>
</template>

<script setup lang="tsx">
import { type DataTableColumns, NButton, NSpace, NTag, type FormInst, type FormRules, type SelectOption } from 'naive-ui'
import { repairOrderPageApi, repairOrderAddApi, repairOrderEditApi, repairOrderDeleteApi, repairOrderUpdateStatusApi } from '@/api/repair-order'
import { dormitoryAllApi } from '@/api/dormitory'
import { useAuthStore } from '@/stores'
import { to } from 'await-to-js'

const authStore = useAuthStore()
const isAdmin = computed(() => authStore.user.role === '管理员')
const isStudent = computed(() => !isAdmin.value)

const loading = ref(false)
const submitting = ref(false)
const tableData = ref<Api.RepairOrder.RepairOrder[]>([])
const showModal = ref(false)
const isEdit = ref(false)
const formRef = ref<FormInst | null>(null)

// 状态弹窗
const showStatusModal = ref(false)
const statusSubmitting = ref(false)
const statusFormRef = ref<FormInst | null>(null)
const statusForm = reactive({
  id: 0,
  currentStatus: '',
  status: '',
})

const statusOptions: SelectOption[] = [
  { label: '待处理', value: '待处理' },
  { label: '处理中', value: '处理中' },
  { label: '已完成', value: '已完成' },
]

const statusRules: FormRules = {
  status: { required: true, message: '请选择新状态', trigger: 'change' },
}

// 宿舍列表（选择用）
const dormLoading = ref(false)
const dormitoryOptions = ref<SelectOption[]>([])

const repairTypeOptions: SelectOption[] = [
  { label: '灯具', value: '灯具' },
  { label: '水龙头', value: '水龙头' },
  { label: '门锁', value: '门锁' },
  { label: '空调', value: '空调' },
  { label: '热水器', value: '热水器' },
  { label: '窗户', value: '窗户' },
  { label: '马桶', value: '马桶' },
  { label: '其他', value: '其他' },
]

const statusType: Record<string, 'warning' | 'info' | 'success' | 'error'> = {
  '待处理': 'warning',
  '处理中': 'info',
  '已完成': 'success',
  '已关闭': 'error',
}

const initForm = () => ({
  id: 0,
  userId: 0,
  dormitoryId: null,
  title: '',
  repairType: '',
  description: '',
  status: '待处理',
  createTime: '',
})
const form = reactive<Api.RepairOrder.RepairOrder>(initForm())

const formRules: FormRules = {
  dormitoryId: { required: true, type: 'number', message: '请选择所属宿舍', trigger: 'change' },
  title: { required: true, message: '请输入报修标题', trigger: 'blur' },
  repairType: { required: true, message: '请选择故障类型', trigger: 'change' },
}

const columns = computed<DataTableColumns<Api.RepairOrder.RepairOrder>>(() => {
  const cols: DataTableColumns<Api.RepairOrder.RepairOrder> = [
    { title: '报修标题', key: 'title', width: 150, ellipsis: { tooltip: true } },
  ]

  // 管理员可见学生姓名、宿舍信息
  if (isAdmin.value) {
    cols.push({ title: '学生姓名', key: 'studentName', width: 100 })
    cols.push({
      title: '宿舍信息',
      key: 'dormitoryInfo',
      width: 120,
      render(row) {
        return row.building ? `${row.building} ${row.roomNum}` : '-'
      },
    })
  }

  cols.push(
    { title: '故障类型', key: 'repairType', width: 90 },
    {
      title: '故障描述',
      key: 'description',
      width: 160,
      ellipsis: { tooltip: true },
    },
    { title: '报修时间', key: 'createTime', width: 170 },
    {
      title: '处理状态',
      key: 'status',
      width: 100,
      render(row) {
        return <NTag type={statusType[row.status] || 'default'}>{row.status}</NTag>
      },
    },
    {
      title: '操作',
      key: 'operation',
      width: isAdmin.value ? 120 : 200,
      fixed: 'right',
      render(row) {
        if (isAdmin.value) {
          return (
            <NButton type="primary" size="small" onClick={() => handleOpenStatus(row)}>
              更新状态
            </NButton>
          )
        }
        return (
          <NSpace>
            <NButton type="primary" size="small" disabled={row.status !== '待处理'} onClick={() => handleEdit(row)}>
              编辑
            </NButton>
            <NButton type="error" size="small" onClick={() => handleDelete(row)}>删除</NButton>
          </NSpace>
        )
      },
    },
  )
  return cols
})

const pagination = reactive({
  page: 1,
  pageSize: 10,
  itemCount: 0,
  onChange: (page: number) => {
    pagination.page = page
    getPageList()
  },
})

async function loadDormitories() {
  dormLoading.value = true
  const [err, data] = await to(dormitoryAllApi())
  dormLoading.value = false
  if (err) return
  dormitoryOptions.value = data.map((d: Api.Dormitory.Dormitory) => ({
    label: `${d.building} ${d.floorNum}层 ${d.roomNum}`,
    value: d.id,
  }))
}

async function getPageList() {
  loading.value = true
  const [err, data] = await to(repairOrderPageApi({ current: pagination.page, size: pagination.pageSize }))
  loading.value = false
  if (err) {
    tableData.value = []
    return
  }
  tableData.value = data.records
  pagination.itemCount = data.total
}

// 学生页面加载宿舍列表
if (isStudent.value) {
  loadDormitories()
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

function handleEdit(row: Api.RepairOrder.RepairOrder) {
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
  const submitData = { ...form, dormitoryId: form.dormitoryId }
  const api = isEdit.value ? repairOrderEditApi(submitData) : repairOrderAddApi(submitData)
  const [submitErr] = await to(api)
  submitting.value = false
  if (submitErr) return
  window.$message.success(isEdit.value ? '修改成功' : '添加成功')
  showModal.value = false
  getPageList()
}

function handleDelete(row: Api.RepairOrder.RepairOrder) {
  const dialogInstance = window.$dialog.warning({
    title: '温馨提示',
    content: `确定要删除报修「${row.title}」吗？`,
    positiveText: '确定',
    negativeText: '取消',
    onPositiveClick: async () => {
      dialogInstance.loading = true
      const [err] = await to(repairOrderDeleteApi(row.id))
      dialogInstance.loading = false
      if (err) return false
      window.$message.success('删除成功')
      getPageList()
      return true
    },
  })
}

// 管理员更新状态
function handleOpenStatus(row: Api.RepairOrder.RepairOrder) {
  statusForm.id = row.id
  statusForm.currentStatus = row.status
  statusForm.status = ''
  showStatusModal.value = true
}

async function handleUpdateStatus() {
  statusSubmitting.value = true
  const [err] = await to(statusFormRef.value!.validate())
  if (err) {
    statusSubmitting.value = false
    return
  }
  const [submitErr] = await to(repairOrderUpdateStatusApi({ id: statusForm.id, status: statusForm.status }))
  statusSubmitting.value = false
  if (submitErr) return
  window.$message.success('更新状态成功')
  showStatusModal.value = false
  getPageList()
}
</script>

<style scoped></style>
