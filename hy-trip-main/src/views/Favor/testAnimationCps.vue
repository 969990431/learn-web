<template>

  <div class="animation" :class="{ before: true, after:index <= 9 ? true : showAni }">
    {{ index }}
  </div>
</template>

<script setup>
defineProps({
  index: {
    type: String,
    default: ""
  },
  showAni: {
    type: Boolean,
    default: false,
    set(value){
      console.log("=====",value)
    }
  }
})
</script>

<style lang="less" scoped>
.animation {
  width: 300px;
  height: 100px;
  background: red;
  color: white;
}

.before {
  transform: translateY(10%);
  opacity: 0;
}

.after {
  transform: translateY(0%);
  opacity: 1;
  transition: all 500ms ease;
}
</style>