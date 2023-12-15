<template>
  <q-page padding>
    <q-slider
        :autoplay="3000"
        :pagination="true"
        :navigation="true"
        :slides-per-view="3"
    >
      <q-slide
          v-for="(book, index) in books"
          :key="index"
      >
        <div class="q-pa-md">
          <img :src="book.image" alt="Book Cover" class="q-mb-sm"/>
          <q-card>
            <q-card-section>
              <q-card-title>{{ book.title }}</q-card-title>
              <q-card-subtitle>{{ book.author }}</q-card-subtitle>
            </q-card-section>
          </q-card>
        </div>
      </q-slide>
    </q-slider>
  </q-page>
</template>

<script>
export default {
  data() {
    return {
      books: [
        {title: 'Book 1', author: 'Author 1', image: 'url_to_image_1'},
        {title: 'Book 2', author: 'Author 2', image: 'url_to_image_2'},
        {title: 'Book 3', author: 'Author 3', image: 'url_to_image_3'},
        // Add more books as needed
      ],
    };
  },
};
</script>

<style scoped>
/* Add your custom styles here if needed */
</style>