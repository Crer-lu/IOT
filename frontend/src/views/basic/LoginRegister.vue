<template>
    <div class="login">
        <div class="login-form">
            <div class="login-form-head">
                <img class="logo" src="../../assets/logo.png" />
                <div class="title">IOT物联网管理系统</div>
            </div>
            <a-form ref="formLogRegRef" :rules="rules" class="user-layout-login" :model="formLogReg" @submit="handleSubmit">
                <a-tabs default-active-key="tab1" centered @change="handleTabClick">
                >
                    <a-tab-pane key="tab1" tab="登录">
                        <a-form-item has-feedback name="email" >
                            <a-input size="large" type="text" placeholder="邮箱地址" v-model:value="formLogReg.email" autocomplete="off">
                                <template #prefix>
                                    <MailOutlined />
                                </template>
                            </a-input>
                        </a-form-item>

                        <a-form-item has-feedback name="password">
                            <a-input-password size="large" placeholder="密码" v-model:value="formLogReg.password" autocomplete="off">
                                <template #prefix>
                                    <LockOutlined />
                                </template>
                            </a-input-password>
                        </a-form-item>

                        <a-form-item style="margin-top: 24px">
                            <a-button size="large" type="primary" htmlType="submit" class="login-button" block :disabled=!logInfoStatus>
                                登录
                            </a-button>
                        </a-form-item>
                    </a-tab-pane>

                    <a-tab-pane key="tab2" tab="注册">
                        <a-form-item has-feedback name="name">
                            <a-input size="large" type="text" placeholder="用户名" v-model:value="formLogReg.name">
                                    <template #prefix>
                                        <UserOutlined />
                                    </template>
                            </a-input>
                        </a-form-item>
                        <a-form-item has-feedback name="phone">
                            <a-input size="large" type="number" :min='0' :precision="0" placeholder="手机号" v-model:value="formLogReg.phone">
                                    <template #prefix>
                                        <PhoneOutlined />
                                    </template>
                            </a-input>
                        </a-form-item>
                        <a-form-item has-feedback name="email">
                            <a-input size="large" type="text" placeholder="邮箱地址" v-model:value="formLogReg.email">
                                    <template #prefix>
                                        <MailOutlined />
                                    </template>
                            </a-input>
                        </a-form-item>

                        <a-form-item has-feedback name="password">
                            <a-input-password size="large" placeholder="密码" v-model:value="formLogReg.password">
                                    <template #prefix>
                                        <LockOutlined />
                                    </template>
                            </a-input-password>
                        </a-form-item>

                        <a-form-item style="margin-top: 24px">
                            <a-button size="large" type="primary" htmlType="submit" class="login-button" block :disabled=!regInfoStatus>
                                注册
                            </a-button>
                        </a-form-item>
                    </a-tab-pane>
                </a-tabs>
            </a-form>
        </div>
    </div>
</template>

<script>
import { PhoneOutlined, UserOutlined, LockOutlined, MailOutlined } from '@ant-design/icons-vue';

import { computed, reactive, ref } from 'vue';
import API from "@/plugins/axiosInstance"
import HeadNav from '@/components/headNav.vue';

export default {
    name: 'LoginRegister',
    components: {
        UserOutlined,
        LockOutlined,
        MailOutlined,
        PhoneOutlined
    },
    data() {
        return {
            currentTab: 'tab1',
        }
    },
    methods: {
        handleTabClick(key) {
            this.currentTab = key
            this.$refs.formLogRegRef.resetFields()
        },
        handleSubmit() {
            const formref = this.$refs.formLogRegRef
            if(this.currentTab === "tab1"){
                console.log("登录成功")
                const param = {
                    email: this.formLogReg.email,
                    password: this.formLogReg.password
                }
                console.log(param)
                API({
                    method: 'post',
                    url: '/api/user/login',
                    data: param
                })
                .then((res) => {
                    console.log(res)
                    if (res.data.status == 200) {
                        // 保存信息
                        this.$store.commit('setEmail', param.email)
                        this.$store.commit('setUserid', res.data.data.userid)
                        this.$store.commit('setToken', res.data.data.token)
                        console.log(this.$store.state.user.token)
                        console.log(this.$store.state.user.email)
                        console.log(this.$store.state.user.userid)
                        this.$router.push({path:'/user/info', replace:true})// todo 右上角登录没变化
                    } else {
                        window.alert(res.data.message)
                    }
                })
            }      
            else if(this.currentTab === "tab2"){
                    console.log("注册成功")
                    const param={
                        name:this.formLogReg.name,
                        email:this.formLogReg.email,
                        password: this.formLogReg.password,
                        phone: this.formLogReg.phone
                    }
                    console.log(param)
                    API({
                        method: 'post',
                        url: '/api/user/register',
                        data: param
                    })
                    .then((res) => {
                        console.log(res)
                        if (res.data.status == 200) {
                            window.alert("注册成功！请登录")
                            location.reload()
                        } else {
                            window.alert(res.data.message)
                        }
                    })
                    .catch(function (error) {
                        console.log(error);
                    });
                }
            }

    },
    setup() {
        const formLogReg = reactive({
            name: '',
            email: '',
            password: '',
            phone: '',
        });

        const formLogRegRef = ref();

        const checkEmail = async(_rule, value) => {
            const regex = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/
            if (!regex.test(value)) {
                return Promise.reject('邮箱格式错误')
            }
            return Promise.resolve()
        }

        const checkPhone = async(_rule, value) => {
            const regex = /^1[3456789]\d{9}$/
            if (!regex.test(value)) {
                return Promise.reject('手机号格式错误')
            }
            return Promise.resolve()
        }

        const checkPassword = async(_rule, value) => {
            const regex = /^[A-Za-z0-9]{6,}$/
            if (!regex.test(value)) {
                return Promise.reject('密码只能由数字和字母组成且不少于6位')
            }
            return Promise.resolve()
        }

        const checkUsername =  async(_rule, value) => {
            const regex = /^.{6,}$/
            if (!regex.test(value)) {
                return Promise.reject('用户名长度不得少于6位')
            }
            return Promise.resolve()
        }

        const logInfoStatus = computed(
            () =>{
                const regex_email = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/
                const regex_password = /^[A-Za-z0-9]{6,}$/
                return regex_email.test(formLogReg.email) && regex_password.test(formLogReg.password)
            }
        )

        const regInfoStatus = computed(
            () =>{
                const regex_email = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/
                const regex_password = /^[A-Za-z0-9]{6,}$/
                const regex_name = /^.{6,}$/
                const regex_phone = /^1[3456789]\d{9}$/
                return regex_email.test(formLogReg.email) && regex_password.test(formLogReg.password) && regex_name.test(formLogReg.name) && regex_phone.test(formLogReg.phone)
            }
        )
        
        const rules = {
            name: [
                {
                    validator: checkUsername,
                    trigger: 'change',
                },
            ],
            email: [
                {
                    validator: checkEmail,
                    trigger: 'change',
                },
            ],
            password: [
                {
                    validator: checkPassword,
                    trigger: 'change',
                },
            ],
            phone: [
                {
                    validator: checkPhone,
                    trigger: 'change',
                },
            ]
        };
        return {
            formLogReg,
            formLogRegRef,
            rules,
            logInfoStatus,
            regInfoStatus
        }
    },
    mounted:function(){
        console.log("LoginRegister mounted")
        const email = localStorage.getItem("email")
        if(email){
            console.log("已登录，跳转至用户页面")
            this.$router.push({path:'/user/info', replace:true})
        }else{
            console.log("未登录")
        }
    },
};
</script>

<style scoped>
.login-form-head {
    display: flex;
    justify-content: center;
    align-items: center;
}

.logo {
    width: 40px;
    height: 40px;
}

.title {
    font-size: 20px;
    margin-left: 10px;
}

.login {
    width: 100%;
    height: 100%;
    display: flex;
    min-width: 1200px;
    min-height: 800px;
}

.login-form {
    width: 400px;
    height: 50%;
    margin: auto;
    padding-left: 30px;
    padding-right: 30px;
    padding-top: 30px;
    padding-bottom: 30px;
}

</style>
