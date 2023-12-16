<script lang="ts" setup>
import {ref} from 'vue'


const slide = ref(1);
const autoplay = ref(true);
const libro = "Soy un libro"
const precio = 1000
</script>
<template>
 <q-card>
  <q-card-section>
<q-card-section>
  <p>
    <h3 align="center">Recomendaciones</h3>
  </p>
</q-card-section>
  <div class="q-pa-md">
    <q-carousel
        v-model="slide"
        transition-prev="slide-right"
        transition-next="slide-left"
        swipeable
        animated
        :autoplay="autoplay"
        control-color="amber"
        navigation
        padding
        arrows
        height="300px"
        class="bg-grey-9 shadow-2 rounded-borders"
    >
      <q-carousel-slide :name="1" class="column no-wrap">

        <div class="row fit justify-start items-center q-gutter-xs q-col-gutter no-wrap">

          <q-img class="rounded-borders col-6 " src="/libro1.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro2.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro3.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro4.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro5.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro6.png" width="120px"/>

        </div>

      </q-carousel-slide>
      <q-carousel-slide :name="2" class="column no-wrap">
        <div class="row fit justify-start items-center q-gutter-xs q-col-gutter no-wrap">


          <q-img class="rounded-borders col-6 " src="/libro7.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro8.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro9.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro10.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro11.png" width="120px"/>
          <q-img class="rounded-borders col-6 " src="/libro12.png" width="120px"/>
        </div>
      </q-carousel-slide>
    </q-carousel>
  </div>
  </q-card-section>
 </q-card>
</template>

/style>