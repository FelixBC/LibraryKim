<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Book, Gender, Genre} from "./types.ts";
import EditBookModal from "./EditBookModal.vue";
import {useRouter} from "vue-router";

const API_URL = "http://localhost:3000/books";
const API_URL_GENRES = "http://localhost:3000/books/general_params";
const API_URL_AUTHORS = "http://localhost:3000/authors";
const books = ref<Book[]>([]);
const editingBook = ref<Book | null>(null);
const showModal = ref(false);
const filterValue = ref('')
const itemsPerPage = ref(10);
const router = useRouter();

const genres = ref<Gender[]>([]);
const authors = ref<Author[]>([]);


const paginatedBooks = computed(() => {
  const filteredBooks = books.value.filter(book =>
      book.title.toLowerCase().includes(filterValue.value.toLowerCase()) ||
      displayGenre(book.genreId).toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredBooks.slice(0, itemsPerPage.value);
});
const editBook = async (id) => {
  showModal.value = true;
  const book = books.value.find(book => book.id === id)
  if (book) {
    editingBook.value = book;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onModalClose = () => {
  showModal.value = false;
};
const deleteBook = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  books.value = books.value.filter(person => person.id !== id)
}
const onUpdateBook = async ({id, title, price, quantity}) => {
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      book: {
        title: title,
        quantity: quantity,
        price: price
      }
    })
  });
  const data = await res.json();
  const index = books.value.findIndex(book => book.id === id);
  const currentPath = router.currentRoute.value.fullPath;

  if (index !== -1) {
    books.value[index].name = data.name;
  }

  showModal.value = false;
  router.replace({path: '/redirect', query: {to: currentPath}}).then(() => {
    router.replace({path: currentPath});
  });
};

const displayAuthor = (authorId) => {
  const author = authors.value.find(author => author.id === authorId)
  if (author) {
    return author.name
  }
  return ''
}
const displayGenre = (genreId) => {
  const genre = genres.value.find(genre => genre.id === genreId)
  if (genre) {
    return genre.name
  }
  return ''
}

onMounted(async () => {
  const resGenres = await fetch(API_URL_GENRES);
  const res = await fetch(API_URL);
  const data = await res.json();
  const resAuthors = await fetch(API_URL_AUTHORS);
  books.value = data as Book[];
  const dataGenres = await resGenres.json();
  genres.value = dataGenres as Genre[];
  const dataAuthors = await resAuthors.json();
  authors.value = dataAuthors as Genre[];
});

</script>
<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Lista de Libros</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots label="Buscar por titulo o genero">
            <template v-slot:before>
              <q-icon name="person"/>
            </template>

            <template v-slot:append>
              <q-icon name="search"/>
            </template>
          </q-input>
        </q-card-section>
        <q-card-section>
          <q-card>
            <q-markup-table>
              <thead>
                <tr class="text-center">
                  <th>Titulo</th>
                  <th>Autor</th>
                  <th>ISBN</th>
                  <th>Genero</th>
                  <th>Cantidad</th>
                  <th>Rentados</th>
                  <th>Precio de Venta</th>
                  <th>Rating</th>
                </tr>
              </thead>
              <tbody v-for="book in paginatedBooks" :key="book.id">
                <tr class="text-center">
                  <td>{{ book.title }}</td>
                  <td>{{ displayAuthor(book.authorId) }}</td>
                  <td>{{ book.isbn }}</td>
                  <td>{{ displayGenre(book.genreId) }}</td>
                  <td>{{ book.quantity }}</td>
                  <td>{{ book.rented }} / {{ book.quantity}}</td>
                  <td>RD ${{ book.price }}</td>
                  <td>{{ book.rating }}</td>
                  <td>
                    <div>
                      <q-btn v-if="!showModal" round color="secondary" icon="edit" @click="editBook(book.id)"
                             class="small-btn"></q-btn>
                      <q-btn round color="secondary" icon="delete" @click="deleteBook(book.id)"
                             class="small-btn"></q-btn>
                    </div>
                  </td>
                  <th></th>
                </tr>
              </tbody>
              <div>
              </div>
            </q-markup-table>
          </q-card>
        </q-card-section>
      </q-card>
    </q-page>
    <EditBookModal v-model:show="showModal" v-bind="editingBook" @update:show="showModal = $event"
                   @save="onUpdateBook"></EditBookModal>
  </q-layout>
</template>
<style scoped>

</style>