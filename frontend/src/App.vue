<template>
  <div id="app">
    <a-layout style="Height:100%">
      <div>
        <headNav></headNav>
      </div>
      <a-layout-content style scoped="minHeight:calc(100% - 250px)">
        <router-view></router-view>
      </a-layout-content>
        <a-layout-footer style="text-align:center; Height:30px; position: relative; bottom: 0;">
          <nfooter />
        </a-layout-footer>
    </a-layout>
  </div>
</template>

<script>
import headNav from '@/components/headNav'
import footer from '@/components/footer'
export default {
  name: 'app',
  components: {
    'headNav': headNav,
    'nfooter': footer
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  margin: 0 auto;
  min-width: 1200px;
  height: 100%;
  width:100%;
  margin:0 0 0 0;
  overflow:hidden hidden;
  background-color: white;
}
</style>