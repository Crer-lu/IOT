<template>
    <div class="menu-container">
        <div class="left-menu">
            <a-menu v-model:selectedKeys="current" theme="light" mode="horizontal">
                <a-menu-item key="home" @click="goTo('/home')">
                    <HomeOutlined />
                    首页
                </a-menu-item>
                <a-menu-item key="help" @click="goTo('/help')">
                    <AppstoreOutlined />
                    帮助
                </a-menu-item>
                <a-menu-item key="contact" @click="goTo('/contact')">
                    <PhoneOutlined />
                    联系我们
                </a-menu-item>
            </a-menu>
        </div>
        <div class="right-menu">
            <a-menu v-model:selectedKeys="current" theme="light" mode="horizontal" :key="flush"> 
                <!-- 此处为右侧菜单的其他项，例如用户菜单 -->
                <!-- TODO：右上角登录逻辑要改 -->
                <template v-if="showlogin">
                    <a-sub-menu key="user">
                        <template #title>
                            <UserOutlined />
                            {{ showlogin }}
                        </template>
                        <a-menu-item key="info"  @click="goTo('/user/info')">
                            <UserOutlined />
                            个人中心
                        </a-menu-item>
                        <a-menu-item key="total"  @click="goTo('/user/total')">
                            <BarChartOutlined />
                            总览
                        </a-menu-item>
                        <a-menu-item key="device" @click="goTo('/user/device')">
                            <AppleOutlined />
                            设备管理
                        </a-menu-item>
                        <a-menu-item key="message" @click="goTo('/user/message')">
                            <MailOutlined/>
                            消息统计
                        </a-menu-item>
                        <a-menu-item key="logout" @click="exit">
                            <LogoutOutlined />
                            退出登录
                        </a-menu-item>
                    </a-sub-menu>
                </template>
                <template v-else>
                    <a-menu-item key="login" @click="goTo('/login')">
                        <UserOutlined />
                        登录
                    </a-menu-item>
                </template>
            </a-menu>
        </div>
    </div>
</template>

<script>

import { h, ref } from 'vue';
import { LogoutOutlined, CommentOutlined, BarChartOutlined, AppleOutlined, HomeOutlined, AppstoreOutlined, PhoneOutlined, UserOutlined, LockOutlined, MailOutlined } from '@ant-design/icons-vue';

export default {
    data: () => ({
        flush: 0,
        showlogin: localStorage.getItem('email'),
    }),
    setup(){
        const current = ref(['mail']);
        return {
            current,
        }
    },
    components: {
        LogoutOutlined,
        BarChartOutlined,
        AppleOutlined,
        PhoneOutlined,
        AppstoreOutlined,
        HomeOutlined,
        UserOutlined,
        LockOutlined,
        MailOutlined,
        CommentOutlined
    },
    methods: {
        goTo(path) {
            this.$router.push({ path: path, replace: true });
        },
        exit() {
            this.$store.commit('logout')
            this.showlogin = null;
        },
        forceRender(){
            this.flush++;
        }
    },
    watch: {
        'this.$router.currentRoute.path': function (){
            this.forceRender();
            console.log("flush="+this.flush)
            this.showlogin = localStorage.getItem('email');
        }
    }
};
</script>

<style scoped>
.menu-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: white;
}

.logo{
    align-items: center;
}

.right-menu {
    justify-content: flex-end; /* 使内容向右对齐 */
}

</style>