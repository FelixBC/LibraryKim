<script lang="ts" setup>
import {onMounted, ref} from 'vue';
import {useRouter} from 'vue-router';
import {Book, Gender, Genre} from "./types.ts";

const title = ref<string | null>(null);
const author = ref<string | null>(null);
const isbn = ref<string | null>(null);
const quantity = ref<string | null>(null);
const price = ref<float | null>(null);
const rating = ref<number | null>(null);
const imageUrl = ref<string | null>(null);

const genres = ref<Gender[]>([]);

const selectedValueGenres = ref<string | null>(null)

const API_URL = "http://localhost:3000/books";
const API_URL_GENRES = "http://localhost:3000/books/general_params";
const router = useRouter();

const createBook = async () => {
  try {
    const res = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        book: {
          title: title.value,
          author: author.value,
          isbn: isbn.value,
          genreId: selectedValueGenres.value.id,
          quantity: quantity.value,
          price: price.value,
          rating: rating.value,
          imageUrl: imageUrl.value
        }
      })
    });
    if (!res.ok) {
      throw new Error('Error creating book');
    }
    await router.push('/books');
  } catch (error) {
    console.error('Failed to create book:', error);
    // Handle the error appropriately
  }
};

const filterOptionsGenres = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsGenres.value = genders.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filterOptionsGenres.value = genres.value.filter(gender => {
      const fullName = `${gender.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

onMounted(async () => {
  const resGenres = await fetch(API_URL_GENRES);

  const dataGenres = await resGenres.json();
  genres.value = dataGenres as Genre[];
});
</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Crear Libro</h4>
          </q-card-section>
          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="title"
                    label="Titulo *"
                    hint="El señor de los anillos"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir un titulo']"/>
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="author"
                    label="Autor *"
                    hint="John Ronald Reuel Tolkien"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir el author']"/>
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="isbn"
                    label="ISBN *"
                    hint="9780007322596"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'El ISBN es requerido']"/>
              </q-card-section>
              <q-card-section>
                <q-select
                    filled
                    v-model="selectedValueGenres"
                    bg-color="grey-4"
                    label="Genero"
                    option-value="id"
                    option-label="name"
                    :options="genres"
                    :filter="filterOptionsGenres"/>

              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="quantity"
                    label="Cantidad *"
                    hint="3"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir el total de libros']"/>
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="price"
                    label="Precio *"
                    hint="RD$ 500.00"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir el precio por unidad']"/>
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="rating"
                    label="Rating *"
                    hint="0 - 5 estrellas"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir el rating ']"/>
              </q-card-section>

              <q-card-section>
                <q-input
                    filled
                    v-model="imageUrl"
                    label="URL de Imagen *"
                    hint="https://my-image-url.com/my_image.png"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir la URL de la imagen (completa) ']"/>
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createBook">Crear</q-btn>
              <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
            </div>
          </div>
        </q-card-section>
      </q-card>
    </q-form>
  </q-page>
</template>

<style scoped>
</style>