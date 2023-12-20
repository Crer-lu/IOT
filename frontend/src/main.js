import { createApp } from 'vue';
import App from './App.vue';
import router from './route/index.js';
import store from './store';
import Antd from 'ant-design-vue'
import axios from '@/plugins/axiosInstance.js'

const app = createApp(App)
app.use(store)
app.use(router)
app.use(Antd)
app.mount('#index')
app.config.globalProperties.$axios = axios