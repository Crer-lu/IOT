<template>
    <div>
        <div style="padding: 5px">
            <a-row :gutter="16">
                <a-col :span="12">
                    <a-card hoverable style="margin-top: 5px; margin-bottom: 5px">
                        <div id="pieChart" style="width: 100%; height: 30vh; margintop: 10px"></div>
                        <a-card-meta title="" style="text-align: center; padding-top: 5px">
                            <template #description> 设备在线情况 </template>
                        </a-card-meta>
                    </a-card>
                </a-col>
                <a-col :span="12">
                    <a-card hoverable style="margin-top: 5px; margin-bottom: 5px">
                        <div id="barChart" style="width: 100%; height: 30vh; margintop: 10px"></div>
                        <a-card-meta title="" style="text-align: center; padding-top: 5px">
                            <template #description> 各类设备数量统计 </template>
                        </a-card-meta>
                    </a-card>
                </a-col>
            </a-row>
            <a-row :gutter="16">
                <a-col :span="24">
                    <a-card hoverable style="margin-top: 5px; margin-bottom: 5px">
                        <div id="lineChart" style="width: 100%; height: 35vh; margintop: 10px"></div>
                        <a-card-meta title="" style="text-align: center; padding-top: 5px">
                            <template #description> 
                                各类设备消息统计 
                            </template>
                        </a-card-meta>
                    </a-card>
                </a-col>
            </a-row>
        </div>
    </div>
</template>
<script>
import * as echarts from "echarts";
import API from "@/plugins/axiosInstance";
import { autoCompleteProps } from "ant-design-vue/es/auto-complete";
export default {
    data() {
        return {
            pieChart: null,
            mypieChart: null,
            barChart: null,
            mybarChart: null,
            lineChart: null,
            mylineChart: null,

            onlineDevice: 0,
            offlineDevice: 0,

            kindList: [],
            barData: [],

            total: [],
            normal: [],
            alert: [],
        };
    },
    methods: {
        drawPie() {
            var option_pie = {
                tooltip: {
                    trigger: "item",
                },
                legend: {
                    top: "5%",
                    left: "center",
                },
                series: [
                    {
                        name: "设备在线情况",
                        type: "pie",
                        radius: ["40%", "70%"],
                        avoidLabelOverlap: false,
                        itemStyle: {
                            borderRadius: 5,
                            borderColor: "#fff",
                            borderWidth: 2,
                        },
                        label: {
                            show: false,
                            position: "center",
                        },
                        emphasis: {
                            label: {
                                show: true,
                                fontSize: "20",
                                fontWeight: "bold",
                            },
                        },
                        labelLine: {
                            show: false,
                        },
                        data: [
                            { value: this.onlineDevice, name: "在线设备" },
                            { value: this.offlineDevice, name: "离线设备" },
                        ],
                    },
                ],
            };
            option_pie && this.mypieChart.setOption(option_pie);
        },
        drawBar() {
            var option_bar = {
                tooltip: {
                    trigger: "item",
                },
                xAxis: {
                    type: "category",
                    data: this.kindList,
                },
                yAxis: {
                    type: "value",
                    interval: 1
                },
                series: [
                    {
                        data: this.barData,
                        type: "bar",
                    },
                ],
            };
            option_bar && this.mybarChart.setOption(option_bar);
        },
        drawLine() {
            var option_line = {
                tooltip: {
                    trigger: "item",
                },
                legend: {
                    data: ["总消息", "报警消息", "正常消息"],
                },
                grid: {
                    left: "3%",
                    right: "4%",
                    bottom: "3%",
                    containLabel: true,
                },
                toolbox: {
                    feature: {
                        saveAsImage: {},
                    },
                },
                xAxis: {
                    type: "category",
                    boundaryGap: false,
                    data: this.kindList,
                },
                yAxis: {
                    type: "value",
                },
                series: [
                    {
                        name: "总消息",
                        type: "line",
                        data: this.total,
                    },
                    {
                        name: "报警消息",
                        type: "line",
                        data: this.alert,
                    },
                    {
                        name: "正常消息",
                        type: "line",
                        data: this.normal,
                    },
                ],
            };
            option_line && this.mylineChart.setOption(option_line);
        },
        groupItems(){
            return this.deviceList.reduce((accumulator, item) => {
                const group = accumulator.find(g => g[0].kind === item.kind);
                if (!group) {
                    accumulator.push([item]);
                } else {
                    group.push(item);
                }
                return accumulator;
            }, []);
        },
        getAllDevice() {
            console.log(this.$store.state.user.userid)
            console.log(this.$store.state.user.token)
            API(
                {
                    method: "get",
                    url: "/api/device/query/list?userid="+this.$store.state.user.userid,
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "token: "+this.$store.state.user.token,
                    },
                }
            )
            .then((res) => {
                if (res.data.status == 200) {
                    console.log(res.data.data);
                    this.deviceList = res.data.data;
                    this.total = res.data.total
                    for (var i = 0; i < this.deviceList.length; i++) {
                        if (this.deviceList[i].status == true)
                            this.onlineDevice += 1;
                        else
                            this.offlineDevice += 1;
                    }
                    const groupdata = this.groupItems()
                    console.log(groupdata)
                    for (var i = 0; i < groupdata.length; i++) {
                        this.kindList.push(groupdata[i][0].kind)
                        this.barData.push(groupdata[i].length)
                    }
                    this.drawPie();
                    this.drawBar();
                } else {
                    window.alert(res.data.message);
                }
            });
        },
        getAllMessage(){ // TODO 有时候会失效？
            API({
                method: "get",
                url: "/api/message/all?userid=" + this.$store.state.user.userid,
                headers:{
                    'Authorization': "token "+ this.$store.state.user.token
                }
            })
            .then((res) => {
                if(res.data.status == 200){
                    console.log(res.data.data)
                    const messages = res.data.data
                    this.total = new Array(this.kindList.length).fill(0);
                    this.normal = new Array(this.kindList.length).fill(0);
                    this.alert = new Array(this.kindList.length).fill(0);
                    for( var i = 0; i < messages.length; i++){
                        for(var j = 0; j < this.kindList.length; j++){
                            if(messages[i].devicekind === this.kindList[j]){
                                this.total[j]++;
                                if(messages[i].alert == true)
                                    this.alert[j]++;
                                else
                                    this.normal[j]++;
                                break;
                            }
                        }
                    }
                    this.drawLine()
                }
                else{
                    window.alert(res.data.message)
                }
            })
        }
    },
    mounted: function () {
        this.getAllDevice()
        this.getAllMessage()
        // 下面是三个图表的初始化
        if (
            !this.mypieChart &&
            typeof this.mypieChart != "undefined" &&
            this.mypieChart != 0
        ) {
            this.pieChart = document.getElementById("pieChart");
            this.mypieChart = echarts.init(this.pieChart);
        }
        if (
            !this.mybarChart &&
            typeof this.mybarChart != "undefined" &&
            this.mybarChart != 0
        ) {
            this.barChart = document.getElementById("barChart");
            this.mybarChart = echarts.init(this.barChart);
        }
        if (
            !this.mylineChart &&
            typeof this.mylineChart != "undefined" &&
            this.mylineChart != 0
        ) {
            this.lineChart = document.getElementById("lineChart");
            this.mylineChart = echarts.init(this.lineChart);
        }
    },
};
</script>
<style></style>