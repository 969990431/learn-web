<template>
  <div class="dashboard">
    <top-count></top-count>
    <pie-echarts></pie-echarts>
  </div>
</template>

<script setup lang="ts">
import  PieEcharts from './c-cpns/pie-echarts.vue';
import TopCount from './c-cpns/top-count.vue'

</script>

<style lang="less" scoped>
.dashboard {

}
</style>
