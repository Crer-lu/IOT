<template>
    <div id="bingMap" class="map-container"></div>
</template>

<script>
export default {
    name: 'BingMap',
    props: {
        apiKey: String,
        zoom: { type: Number, default: 100 },
        polylinePath: Array,
    },
    mounted() {
        this.loadMap();
    },
    methods: {
        loadMap() {
            if (!window.Microsoft) {
                const script = document.createElement('script');
                script.src = `https://www.bing.com/api/maps/mapcontrol?key=${this.apiKey}&callback=loadMap`;
                script.async = true;
                document.head.appendChild(script);
                console.log("loading map");
                window.loadMap = () => {
                    this.initMap();
                };
            } else {
                this.initMap();
            }
        },
        initMap() {
            const map = new window.Microsoft.Maps.Map(document.getElementById('bingMap'), {
                zoom: this.zoom,
            });
            console.log("initing map");
            if (this.polylinePath && this.polylinePath.length) {
                // 创建多段线的位置数组
                const locations = this.polylinePath.map(point => new window.Microsoft.Maps.Location(
                    parseFloat(point.latitude),
                    parseFloat(point.longitude)
                ));
                console.log("hanling map");
                console.log(this.polylinePath)
                console.log(locations);
                const polyline = new window.Microsoft.Maps.Polyline(locations, {
                    strokeColor: 'blue',
                    strokeThickness: 2,
                    strokeOpacity: 0.5,
                });
                map.entities.push(polyline);

                // 调整视图以确保多段线完全可见
                const bounds = window.Microsoft.Maps.LocationRect.fromLocations(locations);
                map.setView({ bounds });
            }
        },
    },
};
</script>

<style>
.map-container {
    width: 100%;
    height: auto;
}
</style>
