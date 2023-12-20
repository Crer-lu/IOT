<template>
    <div>
        <a-card hoverable style="width: 100%" :bordered="false">
            <a-card-meta :title=oldusername :description=email>
                <a-avatar slot="avatar" :src=avatar :size="64" />
            </a-card-meta>
        </a-card>
        <a-divider dashed />
        <a-row>
            <a-col :span="6">
                昵称修改：
            </a-col>
            <a-col :span="6">
                <a-input ref="usernameInput" v-model:value="newusername" :placeholder=oldusername>
                    <template #prefix>
                        <UserOutlined />
                    </template>
                </a-input>
            </a-col>
            <a-col :span="6">
            </a-col>
            <a-col :span="6" />
        </a-row>
        <br>
        <a-row>
            <a-col :span="6">
                手机号修改：
            </a-col>
            <a-col :span="6">
                <a-input ref="phoneInput" v-model:value="newphone" :placeholder=oldphone>
                    <template #prefix>
                        <UserOutlined />
                    </template>
                </a-input>
            </a-col>
            <a-col :span="6">
                <a-button type="dashed" style="margin-left:10px" @click="handleSubmitInfo">信息修改</a-button>
            </a-col>
            <a-col :span="6" />
        </a-row>
        <br>
        <a-row>
            <a-col :span="6">
                密码修改：
            </a-col>
            <a-col :span="6">
                <a-input-password placeholder="原密码" v-model:value="password1">
                </a-input-password>
            </a-col>
            <a-col :span="6"></a-col>
            <a-col :span="6" />
        </a-row>
        <br>
        <a-row>
            <a-col :span="6"></a-col>
            <a-col :span="6">
                <a-input-password placeholder="新密码" v-model:value="password2">
                </a-input-password>
            </a-col>
            <a-col :span="6">
                <a-button type="dashed" style="margin-left:10px" @click="handleSubmitPasswd">密码修改</a-button>
            </a-col>
            <a-col :span="6" />
        </a-row>
    </div>
</template>

<script>
import API from '@/plugins/axiosInstance';
import { UserOutlined, LockOutlined } from '@ant-design/icons-vue';

export default {
    data() {
        return {
            avatar: "https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png",
            oldusername: "",
            newusername: "",
            oldphone: "",
            newphone: "",
            email: this.$store.state.user.email,
            password1: '',
            password2: '',
        }
    },
    exponents: {
        UserOutlined,
        LockOutlined,
    },
    methods: {
        handleSubmitInfo(e) {
            e.preventDefault()
            const param = {
                userid:this.$store.state.user.userid,
                name: this.newusername,
                phone: this.newphone,
            }
            API(
                {
                    method: "POST",
                    url: "/api/user/modify/info",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "token " + this.$store.state.user.token
                    },
                    data: param
                }
            ).then((res) => {
                console.log(res)
                if(res.data.status == 200)
                    this.oldusername = this.newusername
                window.alert(res.data.message)
                location.reload()
            })
        },
        handleSubmitPasswd(e) {
            e.preventDefault()
            var regex = /^[A-Za-z0-9]{6,}$/
            if (!regex.test(this.password1) || !regex.test(this.password2)) {
                alert("密码只能由数字和字母组成且不少于6位");
            }
            else {
                const param = {
                    userid: this.$store.state.user.userid,
                    oldpasswd: this.password1,
                    newpasswd: this.password2,
                }
                API(
                    {
                        method: "POST",
                        url: "/api/user/modify/passwd",
                        headers: {
                            "Content-Type": "application/json",
                            "Authorization": "token " + this.$store.state.user.token
                        },
                        data: param
                    }
                )
                .then((res) => {
                        console.log(res)
                        if (res.data.status === 200) {
                            window.alert("修改成功")
                            location.reload()
                        }
                        else
                            window.alert(res.data.message)
                    })
            }
            console.log(this.password1, this.password2)
        },
    },
    mounted: function () {
        console.log(this.$store.state.user)
        console.log(this.$store.state.user.name)
        API(
            {
                method: "GET",
                url: "/api/user/query/info?userid="+this.$store.state.user.userid,
                headers: {
                    "Authorization": "token " + this.$store.state.user.token
                },
            }
        ).then((res) => {
            if (res.data.status === 200) {
                this.oldusername = res.data.data.name
                this.oldphone = res.data.data.phone
                this.$store.commit('setUser', res.data.data.name)
                this.$store.commit('setPhone', res.data.data.phone)
            }
            else
                window.alert("获取用户信息失败，请重新登录！")
        })
    }
}
</script>