<script lang="ts" setup>
import {onMounted, ref} from 'vue';
import {Reservation} from "./types.ts";
import {useRouter} from "vue-router";

const status = ref<string | null>(null);
const selectedValueBooks = ref<string | null>(null);
const selectedValueClients = ref<string | null>(null);
const books = ref<Event[]>([]);
const clients = ref<Client[]>([]);

const API_URL = "http://localhost:3000/book_checkouts";
const BOOKS_API_URL = "http://localhost:3000/books";
const CLIENTS_API_URL = "http://localhost:3000/users?role=client";
const reservations = ref<Reservation[]>([]);
const router = useRouter();

const createBookCheckout = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      bookCheckout: {
        bookId: selectedValueBooks.value.id,
        clientId: selectedValueClients.value.id
      }
    })
  });

  const data = await res.json();
  reservations.value.push(data);
await router.push('/book-checkouts');

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
const fetchClients = async () => {
  try {
    const response = await fetch(CLIENTS_API_URL,{
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

const filterOptionsBooks = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsBooks.value = books.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsBooks.value = books.value.filter(book => {
      const fullName = `${book.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}
const filterOptionsClients = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsClients.value = clients.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsClients.value = clients.value.filter(client => {
      const fullName = `${client.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

onMounted(() => {
  fetchBooks();
  fetchClients();
});


</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Registrar renta de libro</h4>
          </q-card-section>
          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-select
                    filled
                    v-model="selectedValueBooks"
                    bg-color="grey-4"
                    label="Book"
                    option-value="id"
                    option-label="title"
                    :options="books"
                    :filter="filterOptionsBooks"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe selectionar un libro']"/>
                <q-select
                    filled
                    v-model="selectedValueClients"
                    bg-color="grey-4"
                    label="Client"
                    option-value="id"
                    option-label="email"
                    :options="clients"
                    :filter="filterOptionsClients"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe selectionar un cliente']"/>
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createBookCheckout">Registrar Renta</q-btn>
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
