<template>
  <div class="home">
    <el-row :gutter="20">
      <template v-for="item in 4" :key="item">
        <el-col :span="6">
          <top-card></top-card>
        </el-col>
      </template>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import TopCard from './top-card.vue'
</script>

<style lang="less" scoped>
.home {
}
</style>
