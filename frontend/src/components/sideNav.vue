<template>
    <a-menu mode="inline"
        :style="{ height: '100%', borderRight: 0 }">
        <a-sub-menu key="sub1">
            <template #title>
                <CommentOutlined />
                信息中心
            </template>
            <a-menu-item key="1" @click="goTo('/user/total')">
                <BarChartOutlined />
                总览
            </a-menu-item>
            <a-menu-item key="2" @click="goTo('/user/message')">
                <MailOutlined/>
                消息统计
            </a-menu-item>
            <a-menu-item key="3" @click="goTo('/user/device')">
                <AppleOutlined />
                设备管理
            </a-menu-item>
        </a-sub-menu>
        <a-menu-item key="4" @click="goTo('/user/info')" >
            <UserOutlined/>
            个人中心
        </a-menu-item>
    </a-menu>
</template>

<script>
import { CommentOutlined, BarChartOutlined, AppleOutlined, HomeOutlined, AppstoreOutlined, PhoneOutlined, UserOutlined, LockOutlined, MailOutlined } from '@ant-design/icons-vue';

export default {
    data() {
        return {
        };
    },
    components: {
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
            this.$router.push({path:path, replace: true});
        }
    }
};
</script>