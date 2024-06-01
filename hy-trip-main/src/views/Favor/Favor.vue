<template>
  <div ref="container" class="favor">
    <template v-for="item,index in items" :key="index">
      <div class="number" v-if="index % 2 === 0">
        {{ index }}
      </div>
      <div v-else>
        <testAnimationCpsVue :ref="getAniRef" :index="String(index)" :showAni="index > 9 && item.isVisible" @click="gotoNotFound"/>
      </div>
    </template>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import testAnimationCpsVue from './testAnimationCps.vue';

const aniEls = []

// const getAniRef = value => {
//   console.log(value.$el.offsetTop)
//   aniEls.push(value.$el)
// }
const items = ref([])
for (let i = 0; i < 50; i++) {
  items.value.push({ id: i*2+1, isVisible: false });
}

const aniArray = []
let ani = ref(false)
const container = ref()
onMounted(() => {
  window.addEventListener("scroll", () => {
    console.log(window.scrollY)
    // if(window.scrollY >= 120) {
    //   console.log("显示")
    //   // const item6 = items.value[6]
    //   // item6.isVisible = true
    //   // items.value[6].isVisible = true
    //   items.value.forEach(element,index => {
    //     console.log(index)
    //     if(index === 11) {

    //       element.isVisible = true
    //     }
    //   });
    // }
  })
})

const router = useRouter()
const gotoNotFound = () => {
  router.push("/qqq")
}

const showAni = computed(() => ani.value)

</script>

<style lang="less" scoped>
.favor {
  padding: 40px;
  font-size: 16px;

  .number {
    height: 20px;
  }
}
</style>