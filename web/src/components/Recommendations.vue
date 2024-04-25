<script lang="ts" setup>
import {computed, onMounted, ref} from 'vue'
import {Book} from "./types.ts";

const slide = ref(1);
const autoplay = ref(true);

const API_URL = "http://localhost:3000/books";
const books = ref<Book[]>([]);

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  books.value = data.reduce((acc, item, index) => {
    const groupIndex = Math.floor(index / 6);
    acc[groupIndex] = acc[groupIndex] || [];
    acc[groupIndex].push(item);
    return acc;
  }, []) as [Book[]];
});

const shuffledAndExtendedCollection = computed(() => {
  const shuffled = books.value.sort(() => 0.5 - Math.random());
  return shuffled.flatMap(b => [b, b]);
});

</script>
<template>
  <q-card>
    <q-card-section>
      <q-card-section>
        <p>
          <h3 class="text-center">Recomendaciones por referencia</h3>
        </p>
        <q-input model-value="" label="Libro" label-color="dark"/>
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
            class="bg-grey-9 shadow-2 rounded-borders">
          <q-carousel-slide
              v-for="(bookGroup, bookGroupIndex) in shuffledAndExtendedCollection"
              :key="bookGroupIndex"
              :name="bookGroupIndex" class="column no-wrap">
            <div class="row fit justify-around items-center">
              <q-card
                  v-for="book in bookGroup"
                  class="flex column justify-center half-white-half-black q-mt-5">
                <q-card-section>
                  <q-img class="rounded-borders col-6 "
                         :src="book.imageUrl"
                         width="120px"/>
                </q-card-section>
                <q-card-section class="q-pa-none flex justify-center text-white">
                  <span>{{ book.title }}</span>
                </q-card-section>
                <q-card-section class="q-pa-none flex justify-center text-amber">
                  RD ${{ book.price }}
                </q-card-section>
              </q-card>
            </div>
          </q-carousel-slide>
        </q-carousel>
      </div>
    </q-card-section>
  </q-card>
</template>

<style lang="scss">
.half-white-half-black {
  background-image: linear-gradient(to bottom, white 50%, #181a1b 50%);
}
</style>