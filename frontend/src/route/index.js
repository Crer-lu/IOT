import { createRouter, createWebHistory } from 'vue-router';


const routes = [
  {
    path: '/',
    name: 'index',
    component: () => import('../views/basic/Home.vue'),
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import('../views/basic/Home.vue'),
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/basic/LoginRegister.vue'),
  },
  {
    path:'/user',
    name:'User',
    component:()=>import('../views/user/Index.vue'),
    children:[
      {
        path:'total',
        component: () => import('../views/user/Total.vue'),
      },
      {
        path:'message',
        component: () => import('../views/user/Message.vue'),
      },
      {
        path:'device',
        component: () => import('../views/user/Device.vue'),
      },
      {
        path:'info',
        component: () => import('../views/user/Info.vue'),
      },
    ]
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
