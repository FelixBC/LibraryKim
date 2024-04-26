<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Book, BookCheckout, BookCheckoutStatus } from "./types.ts";
import EditBookCheckoutModal from "./EditBookCheckoutModal.vue";

const API_URL = "http://localhost:3000/book_checkouts";
const BOOKS_API_URL = "http://localhost:3000/books";
const CLIENTS_API_URL = "http://localhost:3000/users?role=client";
const STATUSES_API_URL = "http://localhost:3000/book_checkouts/general_params";


const bookReturnDate = ref<string | null>(null);
const bookCheckouts = ref<BookCheckout[]>([]);
const books = ref<Book[]>([]);
const clients = ref<Client[]>([]);
const bookCheckoutStatuses = ref<BookCheckoutStatus[]>([]);
const editingBookCheckout = ref<BookCheckout | null>(null);

const filterValue = ref('');

const itemsPerPage = ref(10);
const perPageOptions = [
  {label: '5', value: 5},
  {label: '10', value: 10},
  {label: '20', value: 20}
];

const showModal = ref(false);
const handleItemsPerPageChange = (value: number) => {
  itemsPerPage.value = value;
};

const paginatedBookCheckouts = computed(() => {
  const filteredBookCheckouts = bookCheckouts.value.filter(bookCheckout =>
      displayBook(bookCheckout.bookId).toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredBookCheckouts.slice(0, itemsPerPage.value);
});

const fetchBookCheckouts = async () => {
  try {
    const response = await fetch(API_URL);
    if (!response.ok) {
      throw new Error('Failed to fetch book checkouts');
    }
    bookCheckouts.value = await response.json();
    console.log(bookCheckouts.value);
  } catch (error) {
    console.error('Error fetching book checkouts:', error);
  }
};
const fetchClients = async () => {
  try {
    const response = await fetch(CLIENTS_API_URL, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json'
      },
    })

    if (!response.ok) {
      throw new Error('Failed to fetch clients');
    }
    clients.value = await response.json();
    console.log(clients.value);
  } catch (error) {
    console.error('Error fetching clients:', error);
  }
};

const fetchBookCheckoutStatuses = async () => {
  try {
    const response = await fetch(STATUSES_API_URL)
    if (!response.ok) {
      throw new Error('Failed to fetch book checkout statuses');
    }
    bookCheckoutStatuses.value = await response.json();
    console.log(bookCheckoutStatuses.value);
  } catch (error) {
    console.error('Error fetching book checkout statuses:', error);
  }
};

const onUpdateBookCheckout = async ({id, bookId, clientId, bookCheckoutStatusId}) => {
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      bookCheckout: {
        bookId: bookId,
        clientId: clientId,
        statusId: bookCheckoutStatusId
      }
    })
  });
  const data = await res.json();
  const index = bookCheckouts.value.findIndex(bookCheckout => bookCheckout.id === id);

  if (index !== -1) {
    bookCheckouts.value[index].bookId = data.bookId;
    bookCheckouts.value[index].clientId = data.clientId;
    bookCheckouts.value[index].statusId = data.statusId;
  }

  showModal.value = false;
};

const fetchStatuses = async () => {
  try {
    const response = await fetch(STATUSES_API_URL)
    if (!response.ok) {
      throw new Error('Failed to fetch statuses');
    }
    bookCheckoutStatuses.value = await response.json();
    console.log(bookCheckoutStatuses.value);
  } catch (error) {
    console.error('Error fetching statuses:', error);
  }
};

const fetchBooks = async () => {
  try {
    const response = await fetch(BOOKS_API_URL);
    if (!response.ok) {
      throw new Error('Failed to fetch books');
    }
    books.value = await response.json();
    console.log(books.value);
  } catch (error) {
    console.error('Error fetching books:', error);
  }
};

onMounted(async () => {
  await fetchBookCheckouts();
  await fetchBooks();
  await fetchClients();
  await fetchStatuses();
});

const deleteBookCheckout = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  });
  bookCheckouts.value = bookCheckouts.value.filter(bookCheckout => bookCheckout.id !== id);
};

const editBookCheckout = async (id) => {
  showModal.value = true;
  const bookCheckout = bookCheckouts.value.find(bookCheckout => bookCheckout.id === id);

  if (bookCheckout) {
    editingBookCheckout.value = bookCheckout
    window.scroll({
      top: 0,
      behavior: 'smooth'
    });
  }
};

const displayBook = (id) => {
  const book = books.value.find(book => book.id === id);
  if (book) {
    return book.title;
  } else {
    return '';
  }
};
const displayClient = (id) => {
  const client = clients.value.find(client => client.id === id);
  if (client) {
    return client.email;
  }
};

const displayStatus = (id) => {
  const status = bookCheckoutStatuses.value.find(status => status.id === id);
  if (status) {
    return status.name;
  } else {
    return '';
  }
};

</script>

<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Rentas de Libros</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar">
            <template v-slot:prepend>
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
                <th>Cliente</th>
                <th>Estado</th>
              </tr>
              </thead>
              <tbody v-for="bookCheckout in paginatedBookCheckouts" :key="bookCheckout.id">
              <tr class="text-center">
                <td>{{ displayBook(bookCheckout.bookId) }}</td>
                <td>{{ displayClient(bookCheckout.clientId) }}</td>
                <td>{{ displayStatus(bookCheckout.statusId) }}</td>
                <td>
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editBookCheckout(bookCheckout.id)"
                           class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteBookCheckout(bookCheckout.id)"
                           class="small-btn"></q-btn>
                  </div>
                </td>
                <td></td>
              </tr>
              </tbody>
            </q-markup-table>
          </q-card>
        </q-card-section>
      </q-card>
    </q-page>

<!--    <EditBookModal v-model:show="showModal" v-bind="editingBook" @update:show="showModal = $event"-->
<!--                   @save="onUpdateBook"></EditBookModal>-->
    <EditBookCheckoutModal v-model:show="showModal"
                          v-bind="editingBookCheckout"
                          :books="books"
                          :clients="clients"
                          :bookCheckoutStatuses="bookCheckoutStatuses"
                          @save="onUpdateBookCheckout"
                          @hide="showModal = false" />
  </q-layout>
</template>

<style scoped>

</style>
