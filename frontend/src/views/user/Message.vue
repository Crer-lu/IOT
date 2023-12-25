<template>
    <div>
        <div style="position: relative">
            <div style="margin-bottom: 20px;text-align:center;display:block">
                请选择设备：
                <a-select placeholder="请选择设备" style="width:400px;margin-right:20px" @change="handleSelectChange">
                    <a-select-option v-for="item in deviceList" :value="item.deviceid">
                        {{ item.name }}
                    </a-select-option>
                </a-select>
                <a-button type="dashed" @click="showData"> 确定 </a-button>
            </div>
            <a-table :columns="columns" :data-source="messageList" :pagination="ipagination1" @change="handleTableChange2">
                <template v-slot:bodyCell="{column, record}">
                    <template v-if="column.dataIndex==='alert'">
                        <template v-if="record.alert">
                            <a-tag color="red">警告</a-tag>
                        </template>
                        <template v-else>
                            <a-tag color="blue">正常</a-tag>
                        </template>
                    </template>
                </template>
            </a-table>
        </div>
        <div class="map">
            <template v-if="polylinePath.length">
                <BingMap
                v-if="mapRefresh"
                :apiKey=bingapi
                :zoom="10"
                :polylinePath="polylinePath"     />
            </template>
        </div>
    </div>
</template>
<script>
import { nextTick, ref } from "vue";
import API from '@/plugins/axiosInstance';
import BingMap from '@/components/BingMap'; // 确保路径正确
const columns = [
    {
        title: "警告",
        dataIndex: "alert",
        width: "10%",
    },
    {
        title: "信息",
        dataIndex: "info",
        width: "30%",
    },
    {
        title: "经度",
        dataIndex: "latitude",
        width: "15%",
    },
    {
        title: "纬度",
        dataIndex: "longitude",
        width: "15%",
    },
    {
        title: "时间",
        dataIndex: "time_stamp",
        width: "20%",
    },
    {
        title: "数值",
        dataIndex: "value",
        width: "10%",
    },
];

export default {
    data() {
        return {
            columns,
            deviceList: [],
            messageList: [],
            selectId: null,
            timer: undefined,

            user: this.$store.state.user.name,
            //地图坐标
            polylinePath: [],

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
            bingapi: 'Are6BO4zvLK0RGvTIYStj0LeQeGvvcwW9l37PuSAKtsjfhLih-UjZqTaZac7VCNe'
        };
    },
    components: {
        BingMap,
    },
    setup(){
        const mapRefresh = ref(true)
        return {
            mapRefresh
        }
    },
    methods: {
        //这个是实现表格分页跳转的函数
        handleTableChange2(pagination, filters, sorter) {
            this.ipagination1.current = pagination.current;
            this.ipagination1.pageSize = pagination.pageSize;
            filters;
            sorter;
        },
        handleSelectChange(value) {
            console.log(value)
            this.selectId = value
            this.polylinePath = []
            this.getMessage()
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
        showData() {
            console.log("showData")
            this.getMessage()
        },
        getMessage() {
            API({
                method: "get",
                url: "/api/message/info?deviceid=" + this.selectId,
            })
            .then((res) => {
                if (res.data.status === 200) {
                    this.messageList = res.data.data;
                    console.log(this.messageList);
                    var data = []
                    for (var i = 0; i < this.messageList.length; i++) {
                        let result = {}
                        result.latitude = this.messageList[i].latitude
                        result.longitude = this.messageList[i].longitude
                        data.push(result)
                    }
                    console.log("here is data")
                    console.log(data)
                    this.polylinePath = data
                } else {
                    console.log("获取消息失败");
                }
            })
            .catch(function (err) {
                console.log(err);
            });
        },
    },

    mounted: function () {
        console.log(this.$store.state.user);
        console.log(this.$store.state.user.token);
        this.getDevice()
        this.timer = setInterval(this.getMessage, 3000)
    },
    beforeDestroy: function () {
        clearInterval(this.timer)
    }
};
</script>
<style>
.bm-view {
    width: 100%;
    height: 600px;
    margin-top: 20px
}
.map {
    width: 100%;
    height: 400px;
    margin-top: 20px
}
</style>