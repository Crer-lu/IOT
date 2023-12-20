<template>
    <div>
        <!-- 这个是创造设备的弹窗 -->
        <a-modal v-model:open="showCreate" title="新建设备" :footer="null">
            <a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="handleSubmitCreate">
                <a-form-item label="设备名称">
                    <a-input v-model:value="createName" />
                </a-form-item>
                <a-form-item label="设备类型">
                    <a-input v-model:value="createKind" />
                </a-form-item>
                <a-form-item label="设备描述">
                    <a-input v-model:value="createDescription" />
                </a-form-item>
                <a-form-item label="所属用户">
                    <a-input disabled="true" v-model:value="user" :placeholder="this.$store.state.user.name" />
                </a-form-item>
                <a-form-item :wrapper-col="{ span: 12, offset: 5 }">
                    <a-button type="primary" html-type="submit"> 确认 </a-button>
                </a-form-item>
            </a-form>
        </a-modal>

        <!-- 这个是更改设备信息的弹窗 -->
        <a-modal v-model:open="showAlter" title="更改设备信息" :footer="null">
            <a-form :form="form" :label-col="{ span: 5 }" :wrapper-col="{ span: 12 }" @submit="handleSubmitAlter">
                <a-form-item label="设备名称">
                    <a-input v-model:value="alterName" />
                </a-form-item>
                <a-form-item label="设备类型">
                    <a-input v-model:value="alterKind" />
                </a-form-item>
                <a-form-item label="设备描述">
                    <a-input v-model:value="alterDescription" />
                </a-form-item>
                <a-form-item label="上次活跃时间">
                    <a-input disabled="true" v-model:value="alterTime" />
                </a-form-item>
                <a-form-item :wrapper-col="{ span: 12, offset: 5 }">
                    <a-button type="primary" html-type="submit"> 确认 </a-button>
                </a-form-item>
            </a-form>
        </a-modal>

        <div style="position: relative">
            <div style="margin-bottom: 16px">
                <a-button type="dashed" @click="showCreateMadal">新建设备</a-button>
                <div style="float: right">
                    <a-input-search placeholder="请输入要搜索的关键词" style="width: 200px" @search="onSearch" />
                </div>
            </div>
            <a-table :columns="columns" :data-source="deviceList" :pagination="ipagination1" @change="handleTableChange2">
                <template v-slot:kind="{record}">
                    <a-tag color="blue">{{ record.kind }}</a-tag>
                </template>
                <template v-slot:option="{ record }">
                    <a @click="deleteDevice(record.deviceid)">删除设备</a>
                    <a-divider type="vertical" />
                    <a @click="showAlterMadal(record.deviceid, record.name, record.kind, record.description, record.last_active_time)">更改信息</a>
                </template>
            </a-table>
        </div>

    </div>
</template>
<script>
import API from '@/plugins/axiosInstance';

const columns = [
    {
        title: "序号",
        dataIndex: "deviceid",
        width: "8%",
    },
    {
        title: "设备名",
        dataIndex: "name",
        width: "15%",
    },
    {
        title: "类型",
        dataIndex: "kind",
        width: "15%",
    },
    {
        title: "描述",
        dataIndex: "description",
        width: "30%",
    },
    {
        title: "上次活跃时间",
        dataIndex: "last_active_time",
        width: "15%",
    },
    {
        title: "选项",
        width: "17%",
        dataIndex: "option",
    },
];

export default {
    data() {
        return {
            headers: {
                authorization: "authorization-text",
            },
            columns,
            deviceList: [],
            showCreate: false,
            showAlter: false,

            alterId: 0,
            alterName: "",
            alterKind: "",
            alterDescription: "",
            alterTime: "",
            oldName: "",

            createName: "",
            createKind: "",
            createDescription: "",
            user: this.$store.state.user.name,

            //这个是配置表格分页的参数，antd of vue本身对表格数据就有一定处理了
            ipagination1: {
                current: 1,
                pageSize: 5,
                showTotal: (total, range) => {
                    return (
                        "第 " + range[0] + " ~ " + range[1] + " 条，共 " + total + " 条"
                    );
                },
                showQuickJumper: true,
                showSizeChanger: false,
                total: 0,
            },
        };
    },
    methods: {
        //这个是实现表格分页跳转的函数
        handleTableChange2(pagination, filters, sorter) {
            this.ipagination1.current = pagination.current;
            this.ipagination1.pageSize = pagination.pageSize;
            filters;
            sorter;
        },
        showCreateMadal() {
            this.showCreate = true;
        },
        handleSubmitAlter() {
            API(
                {
                    method: "POST",
                    url: "/api/device/modify",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "token " + this.$store.state.user.token
                    },
                    data: {
                        userid: this.$store.state.user.userid,
                        deviceid: this.alterId,
                        name: this.alterName,
                        kind: this.alterKind,
                        description: this.alterDescription,
                    }
                }
            )
            .then((res) => {
                console.log(res.data);
                window.alert(res.data.message);
                location.reload();
            });
        },
        handleSubmitCreate() {
            API({
                method: "POST",
                url: "/api/device/add",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": "token " + this.$store.state.user.token
                },
                data:{
                    userid: this.$store.state.user.userid,
                    name: this.createName,
                    kind: this.createKind,
                    description: this.createDescription,
                }
            })
            .then((res) => {
                if(res.data.status === 200){
                    console.log("创建成功");
                    this.createDescription = "";
                    this.createName = "";
                    this.createKind = "";
                    console.log(res.data);
                    window.alert(res.data.message);
                    location.reload();
                }
                else{
                    console.log("创建失败");
                    window.alert(res.data.message);
                }

                
            });
        },
        showAlterMadal(id, name, kind, description, time) {
            this.showAlter = true;
            this.alterId = id;
            this.alterName = name;
            this.alterKind = kind;
            this.alterDescription = description;
            this.alterTime = time;
            this.oldName = name;
        },
        onSearch(value) {
            console.log(value);
            this.axios
                .get("/api/selectDevice", {
                    params: {
                        token: this.$store.state.user.token,
                        name: value,
                    },
                })
                .then((res) => {
                    if (res.data.status === 200) {
                        this.deviceList = res.data.data;
                    } else {
                        console.log("获取文件失败");
                    }
                })
                .catch(function (err) {
                    console.log(err);
                });
        },

        getDevice() {
            API(
                {
                    method: "get",
                    url: "/api/device/query/list?userid=" + this.$store.state.user.userid,
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "token: " + this.$store.state.user.token,
                    },
                }
            )
            .then((res) => {
                if (res.data.status === 200) {
                    this.deviceList = res.data.data;
                    console.log(this.deviceList);
                } else {
                    console.log("获取文件失败");
                }
            })
            .catch(function (err) {
                console.log(err);
            });
        },
        deleteDevice(value) {
            console.log("delete device[" + value + "]");
            // 这个that很重要哦，this的指向问题
            var that = this;
            this.$confirm({
                title: "您确定删除该设备吗",
                content: "删除了不可恢复哦~",
                okText: "确认",
                okType: "danger",
                cancelText: "取消",
                onOk() {
                    console.log("OK");
                    API({
                        method: "POST",
                        url: "/api/device/delete",
                        headers:{
                            "Content-Type": "application/json",
                            "Authorization": "token: " + this.$store.state.user.token,
                        },
                        data: {
                            userid: this.$store.state.user.userid,
                            deviceid: value,
                        },
                    })
                    .then((res) => {
                        window.alert(res.data.message);
                        location.reload();
                    });
                },
                onCancel() {
                    console.log("Cancel");
                },
            });
        },
    },

    mounted: function () {
        console.log(this.$store.state.user);
        console.log(this.$store.state.user.token);
        this.getDevice();
    },
};
</script>
