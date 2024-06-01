<template>
  <div class="count">
    <h2 ref="numberRef">1000</h2>
  </div>
</template>

<script setup lang="ts">
import { CountUp } from 'countup.js';
import { onMounted, ref } from 'vue';
const numberRef = ref()
onMounted(()=> {

  const numAnim = new CountUp(numberRef.value, 2000, {
    prefix:"¥"
  });
  numAnim.start()
})
</script>

<style lang="less" scoped>
.count {
  padding: 10px;
background-color: red;
}
</style>
