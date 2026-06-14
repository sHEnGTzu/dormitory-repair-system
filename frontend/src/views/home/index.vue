<template>
  <div>
    <!-- 欢迎问候语 -->
    <NCard class="mb-4 from-primary-100 to-primary-50 bg-gradient-to-r dark:from-primary-500 dark:to-primary-200">
      <div class="flex flex-col gap-2 sm:flex-row sm:items-center sm:justify-between">
        <div class="flex items-center gap-3">
          <SvgIcon icon="mdi:hand-wave" class="text-4xl text-yellow-500" />
          <div>
            <h2 class="text-xl font-bold">欢迎回来，{{ username || '管理员' }}！</h2>
            <p class="mt-2 text-sm text-gray-600">今天是 {{ currentDate }} {{ getWeekDay() }}，祝您工作愉快！</p>
          </div>
        </div>
        <NButton type="primary" size="small" @click="refreshData">
          <template #icon>
            <SvgIcon icon="mdi:refresh" />
          </template>
          刷新数据
        </NButton>
      </div>
    </NCard>

    <!-- 待办事项 -->
    <NCard class="mb-4 from-blue-50 to-blue-100 bg-gradient-to-r dark:from-blue-800">
      <div class="mb-4 flex items-center justify-between">
        <div class="flex items-center gap-3">
          <SvgIcon icon="mdi:clipboard-check" class="text-3xl text-blue-500" />
          <h3 class="text-lg font-bold">今日待办</h3>
        </div>
        <div class="flex gap-2">
          <NButton quaternary size="small" @click="addTodo">
            <template #icon>
              <SvgIcon icon="mdi:plus" />
            </template>
            添加任务
          </NButton>
          <NButton quaternary size="small" @click="clearCompletedTodos">
            <template #icon>
              <SvgIcon icon="mdi:delete-sweep" />
            </template>
            清除已完成
          </NButton>
        </div>
      </div>

      <div class="custom-scrollbar max-h-60 overflow-y-auto">
        <TransitionGroup name="todo-list" tag="ul" class="space-y-2">
          <li v-for="(todo, index) in todos" :key="todo.id" class="group">
            <div
              class="flex items-center rounded-lg p-3 transition-all duration-200"
              :class="[
                todo.completed ? 'bg-gray-100 dark:bg-gray-700' : 'bg-white dark:bg-gray-800',
                'hover:shadow-md',
              ]"
            >
              <NCheckbox v-model:checked="todo.completed" @update:checked="updateTodoStatus(index)" />
              <div class="ml-3 flex-1" :class="{ 'line-through text-gray-400': todo.completed }">
                {{ todo.text }}
              </div>
              <div class="mr-2 text-xs text-gray-400">{{ todo.date }}</div>
              <NButton
                quaternary
                circle
                size="small"
                class="opacity-0 transition-opacity group-hover:opacity-100"
                @click="removeTodo(index)"
              >
                <template #icon>
                  <SvgIcon icon="mdi:delete" />
                </template>
              </NButton>
            </div>
          </li>
        </TransitionGroup>

        <div v-if="todos.length === 0" class="flex flex-col items-center justify-center py-6 text-gray-400">
          <SvgIcon name="mdi:clipboard-text" class="mb-2 text-5xl" />
          <p>暂无待办事项</p>
        </div>
      </div>

      <NModal
        v-model:show="showAddTodoModal"
        preset="dialog"
        title="添加新任务"
        positive-text="确认"
        negative-text="取消"
        @positive-click="confirmAddTodo"
        @negative-click="cancelAddTodo"
      >
        <NInput v-model:value="newTodoText" placeholder="请输入任务内容" @keyup.enter="confirmAddTodo" />
      </NModal>
    </NCard>

    <NGrid cols="1 600:2 1000:3" :x-gap="16" :y-gap="16">
      <!-- 宿舍总数 -->
      <NGridItem>
        <NCard class="h-full from-blue-50 to-blue-100 bg-gradient-to-r">
          <div class="flex items-center justify-between">
            <div>
              <div class="text-lg text-black font-bold">宿舍总数</div>
              <div class="mt-2 text-3xl text-black font-bold">{{ stats.dormitoryCount }}</div>
            </div>
            <div class="size-16 flex-center rounded-full bg-blue-500 text-white">
              <SvgIcon icon="mdi:home-city" class="text-3xl" />
            </div>
          </div>
          <div class="mt-4 text-sm text-gray-500">全部宿舍楼栋房间</div>
        </NCard>
      </NGridItem>

      <!-- 报修总数 -->
      <NGridItem>
        <NCard class="h-full from-green-50 to-green-100 bg-gradient-to-r">
          <div class="flex items-center justify-between">
            <div>
              <div class="text-lg text-black font-bold">报修总数</div>
              <div class="mt-2 text-3xl text-black font-bold">{{ stats.repairTotal }}</div>
            </div>
            <div class="size-16 flex-center rounded-full bg-green-500 text-white">
              <SvgIcon icon="mdi:tools" class="text-3xl" />
            </div>
          </div>
          <div class="mt-4 text-sm text-gray-500">全部报修申请</div>
        </NCard>
      </NGridItem>

      <!-- 待处理报修 -->
      <NGridItem>
        <NCard class="h-full from-orange-50 to-orange-100 bg-gradient-to-r">
          <div class="flex items-center justify-between">
            <div>
              <div class="text-lg text-black font-bold">待处理报修</div>
              <div class="mt-2 text-3xl text-black font-bold">{{ stats.pendingCount }}</div>
            </div>
            <div class="size-16 flex-center rounded-full bg-orange-500 text-white">
              <SvgIcon icon="mdi:clock-outline" class="text-3xl" />
            </div>
          </div>
          <div class="mt-4 text-sm text-gray-500">等待维修处理</div>
        </NCard>
      </NGridItem>
    </NGrid>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, reactive, onMounted, watch } from 'vue'
import { NCard, NButton, NGrid, NGridItem } from 'naive-ui'
import { useAuthStore } from '@/stores'
import { dormitoryCountApi } from '@/api/dormitory'
import { repairOrderCountApi } from '@/api/repair-order'

// 定义函数返回今天是星期几
function getWeekDay() {
  const weekDays = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六']
  const date = new Date()
  const weekDay = date.getDay()
  return weekDays[weekDay]
}

// 获取用户信息
const authStore = useAuthStore()
const username = computed(() => authStore.user.username)

// 统计数据显示
const stats = reactive({
  dormitoryCount: 0,
  repairTotal: 0,
  pendingCount: 0,
})

async function fetchStats() {
  try {
    const [dormitoryCount, repairCount] = await Promise.all([dormitoryCountApi(), repairOrderCountApi()])
    stats.dormitoryCount = dormitoryCount
    stats.repairTotal = repairCount.total
    stats.pendingCount = repairCount.pending
  } catch (e) {
    console.error('获取统计数据失败', e)
  }
}

// 获取当前日期
const currentDate = computed(() => {
  const date = new Date()
  return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`
})

// 刷新数据函数
const refreshData = () => {
  fetchStats()
  window.$message.success('数据已刷新')
}

// 待办事项功能
interface Todo {
  id: number
  text: string
  completed: boolean
  date: string
}

// 待办事项列表
const todos = ref<Todo[]>([
  {
    id: 1,
    text: '完成首页数据分析报告',
    completed: false,
    date: '09:30',
  },
  {
    id: 2,
    text: '参加项目周会',
    completed: true,
    date: '14:00',
  },
  {
    id: 3,
    text: '更新系统文档',
    completed: false,
    date: '16:30',
  },
])

// 新任务文本
const newTodoText = ref('')

// 添加任务对话框显示状态
const showAddTodoModal = ref(false)

// 添加任务
const addTodo = () => {
  showAddTodoModal.value = true
}

// 确认添加任务
const confirmAddTodo = () => {
  if (newTodoText.value.trim()) {
    const now = new Date()
    const hours = now.getHours().toString().padStart(2, '0')
    const minutes = now.getMinutes().toString().padStart(2, '0')

    todos.value.push({
      id: Date.now(),
      text: newTodoText.value.trim(),
      completed: false,
      date: `${hours}:${minutes}`,
    })

    newTodoText.value = ''
    showAddTodoModal.value = false
    window.$message.success('任务添加成功')
  } else {
    window.$message.warning('任务内容不能为空')
  }
}

// 取消添加任务
const cancelAddTodo = () => {
  newTodoText.value = ''
  showAddTodoModal.value = false
}

// 移除任务
const removeTodo = (index: number) => {
  todos.value.splice(index, 1)
  window.$message.success('任务已删除')
}

// 更新任务状态
const updateTodoStatus = (index: number) => {
  const todo = todos.value[index]
  if (todo?.completed) {
    window.$message.success(`任务「${todo.text}」已完成`)
  }
}

// 清除已完成的任务
const clearCompletedTodos = () => {
  const completedCount = todos.value.filter((todo) => todo.completed).length
  if (completedCount === 0) {
    window.$message.info('没有已完成的任务')
    return
  }

  todos.value = todos.value.filter((todo) => !todo.completed)
  window.$message.success(`已清除 ${completedCount} 个已完成任务`)
}

// 从本地存储加载待办事项
onMounted(async () => {
  const savedTodos = localStorage.getItem('todos')
  if (savedTodos) {
    try {
      todos.value = JSON.parse(savedTodos)
    } catch (e) {
      console.error('Failed to parse saved todos', e)
    }
  }
  await fetchStats()
})

// 监听待办事项变化，保存到本地存储
watch(
  todos,
  (newTodos) => {
    localStorage.setItem('todos', JSON.stringify(newTodos))
  },
  { deep: true },
)
</script>

<style scoped>
.custom-scrollbar {
  scrollbar-width: thin;
  scrollbar-color: rgba(155, 155, 155, 0.5) transparent;
}

.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background-color: rgba(155, 155, 155, 0.5);
  border-radius: 20px;
}

.todo-list-enter-active,
.todo-list-leave-active {
  transition: all 0.3s ease;
}

.todo-list-enter-from,
.todo-list-leave-to {
  opacity: 0;
  transform: translateX(-20px);
}
</style>
