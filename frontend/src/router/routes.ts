// 此文件由vite-plugin-routes自动生成，仅限meta、redirect属性手动修改
import type { RouteRecordRaw } from 'vue-router'

export const routes: RouteRecordRaw[] = [
  {
    name: '404',
    path: '/404',
    component: () => import('@/views/404/index.vue'),
    meta: {
      title: '404',
      hideInMenu: true,
      hideInTab: true,
      constant: true,
      layout: 'blank',
    },
  },
  {
    name: 'docs',
    path: '/docs',
    meta: {
      title: 'docs',
      hideInMenu: true,
    },
    children: [
      {
        name: 'docs-es-toolkit',
        path: 'es-toolkit',
        component: () => import('@/views/docs/es-toolkit/index.vue'),
        meta: {
          title: 'docs_es-toolkit',
        },
      },
      {
        name: 'docs-naive-ui',
        path: 'naive-ui',
        component: () => import('@/views/docs/naive-ui/index.vue'),
        meta: {
          title: 'docs_naive-ui',
        },
      },
      {
        name: 'docs-naive-ui-components',
        path: 'naive-ui-components',
        component: () => import('@/views/docs/naive-ui-components/index.vue'),
        meta: {
          title: 'docs_naive-ui-components',
        },
      },
      {
        name: 'docs-pinia',
        path: 'pinia',
        component: () => import('@/views/docs/pinia/index.vue'),
        meta: {
          title: 'docs_pinia',
        },
      },
      {
        name: 'docs-pnpm',
        path: 'pnpm',
        component: () => import('@/views/docs/pnpm/index.vue'),
        meta: {
          title: 'docs_pnpm',
        },
      },
      {
        name: 'docs-rengar-admin',
        path: 'rengar-admin',
        component: () => import('@/views/docs/rengar-admin/index.vue'),
        meta: {
          title: 'docs_rengar-admin',
        },
      },
      {
        name: 'docs-unocss',
        path: 'unocss',
        component: () => import('@/views/docs/unocss/index.vue'),
        meta: {
          title: 'docs_unocss',
        },
      },
      {
        name: 'docs-vite',
        path: 'vite',
        component: () => import('@/views/docs/vite/index.vue'),
        meta: {
          title: 'docs_vite',
        },
      },
      {
        name: 'docs-vue',
        path: 'vue',
        component: () => import('@/views/docs/vue/index.vue'),
        meta: {
          title: 'docs_vue',
        },
      },
      {
        name: 'docs-vueuse',
        path: 'vueuse',
        component: () => import('@/views/docs/vueuse/index.vue'),
        meta: {
          title: 'docs_vueuse',
        },
      },
    ],
  },
  {
    name: 'dormitory',
    path: '/dormitory',
    component: () => import('@/views/dormitory/index.vue'),
    meta: {
      title: '宿舍信息',
      order: 1,
      icon: 'mdi:home-city',
    },
  },
  {
    name: 'example',
    path: '/example',
    meta: {
      title: 'example',
      hideInMenu: true,
    },
    children: [
      {
        name: 'example-href',
        path: 'href',
        component: () => import('@/views/example/href/index.vue'),
        meta: {
          title: 'example_href',
        },
      },
      {
        name: 'example-keep-alive',
        path: 'keep-alive',
        component: () => import('@/views/example/keep-alive/index.vue'),
        meta: {
          title: 'example_keep-alive',
        },
      },
    ],
  },
  {
    name: 'home',
    path: '/home',
    component: () => import('@/views/home/index.vue'),
    meta: {
      title: '首页',
      icon: 'mdi:home',
    },
  },
  {
    name: 'login',
    path: '/login',
    component: () => import('@/views/login/index.vue'),
    meta: {
      title: '登录',
      layout: 'blank',
      hideInMenu: true,
    },
  },
  {
    name: 'repair-order',
    path: '/repair-order',
    component: () => import('@/views/repair-order/index.vue'),
    meta: {
      title: '报修管理',
      order: 2,
      icon: 'mdi:tools',
    },
  },
  {
    name: 'setting',
    path: '/setting',
    meta: {
      title: 'setting',
      hideInMenu: true,
    },
    children: [
      {
        name: 'setting-menu',
        path: 'menu',
        component: () => import('@/views/setting/menu/index.vue'),
        meta: {
          title: 'setting_menu',
        },
      },
      {
        name: 'setting-permission',
        path: 'permission',
        meta: {
          title: 'setting_permission',
        },
        children: [
          {
            name: 'setting-permission-list',
            path: 'list',
            component: () => import('@/views/setting/permission/list/index.vue'),
            meta: {
              title: 'setting_permission_list',
            },
          },
        ],
      },
      {
        name: 'setting-role',
        path: 'role',
        meta: {
          title: 'setting_role',
        },
        children: [
          {
            name: 'setting-role-config',
            path: 'config/:id',
            component: () => import('@/views/setting/role/config/[id].vue'),
            meta: {
              title: 'setting_role_config',
            },
          },
          {
            name: 'setting-role-list',
            path: 'list',
            component: () => import('@/views/setting/role/list/index.vue'),
            meta: {
              title: 'setting_role_list',
            },
          },
        ],
      },
      {
        name: 'setting-user',
        path: 'user',
        component: () => import('@/views/setting/user/index.vue'),
        meta: {
          title: 'setting_user',
        },
      },
    ],
  },
]
