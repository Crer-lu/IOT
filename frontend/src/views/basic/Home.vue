<template>
    <div class="home">
        <div>
            <a @click="login"><img class="home-img" src="../../assets/home-background.png" alt="home"></a>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Home',
    data() {
        return {
            //
        }
    },
    methods: {
        login() {
            this.$router.push({path:'/login', replace: true});
        },
    }
}

</script>

<style scoped>
.home {
    height: 100%;
    width: 100%;
    text-align: center;
    background-color: white;
}
.h1 {
    margin-top: 30px;
    font-size: 30px;
}

.home-body {
    padding: 0 30px;
}

.home-img {
    height: 85vh;
    object-fit: cover;
    text-align: center;
    overflow: hidden;
}


</style>