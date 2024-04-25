<script lang="ts" setup>
import {onMounted, ref} from 'vue';
import type {BookCheckout, Reservation} from "./types.ts";
import {useRouter} from "vue-router";

const selectedValueBooks = ref<string | null>(null);
const selectedValueClients = ref<string | null>(null);
const books = ref<Event[]>([]);
const clients = ref<Client[]>([]);

const API_URL = "http://localhost:3000/book_checkouts";
const BOOKS_API_URL = "http://localhost:3000/books";
const CLIENTS_API_URL = "http://localhost:3000/users?role=client";
const bookCheckouts = ref<BookCheckout[]>([]);
const router = useRouter();
const filteredOptionsBooks = ref([]);
const filteredOptionsClients = ref([]);
const bookReturnDate = ref<string | null>(null);
const bookBorrowDate = ref<string | null>(null);

//BorrowDate is equal to the current date

const createBookCheckout = async () => {
  const bookBorrowDate = new Date().toISOString().split('T')[0];
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      bookCheckout: {
        bookId: selectedValueBooks.value.id,
        clientId: selectedValueClients.value.id,
        returnDate: bookReturnDate.value,
        borrowDate: bookBorrowDate.value,
      }
    })
  });
  const createBookCheckout = async () => {
    const borrowDate = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format

    const res = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        bookCheckout: {
          bookId: selectedValueBooks.value.id,
          clientId: selectedValueClients.value.id,
          returnDate: bookReturnDate.value,
          borrowDate: borrowDate
        }
      })
    });

    if (res.ok) {
      const data = await res.json();
      bookCheckouts.value.push(data);
      await router.push('/book-checkouts');

      // Check if all books of this type have been borrowed
      const selectedBook = books.value.find(book => book.id === selectedValueBooks.value.id);
      const booksBorrowed = bookCheckouts.value.filter(checkout => checkout.bookId === selectedBook.id).length;

      if (booksBorrowed > selectedBook.quantity) {
        // Calculate next available borrow date
        const nextBorrowDate = BookCheckout.nextAvailableBorrowDate(selectedBook.id);
        const nextReturnDate = bookReturnDate.value; // Use the selected return date from the form

        // Show modal or trigger notification with next available dates
        showModalMessage(nextBorrowDate, nextReturnDate);
      }
    } else {
      console.error(res.json());
      // Handle error if the request fails
      console.error('Failed to create book checkout');
    }
  };
  };

  const showModalMessage = (nextBorrowDate, nextReturnDate) => {
    // Trigger a modal or notification here to display next available dates
    // Example using Quasar Dialog to show a modal message
    this.$q.dialog({
      title: 'Book Availability Alert',
      message: `All copies of this book are currently borrowed.`,
      prompt: {
        model: nextReturnDate,
        isValid: date => date >= nextBorrowDate, // Validate return date against next borrow date
        type: 'date',
        label: 'Select Return Date',
        rules: [val => val !== null || 'Please select a return date'],
        cancel: true
      }
    }).onOk(data => {
      const selectedReturnDate = data;
      console.log(`Next Borrow Date: ${nextBorrowDate}`);
      console.log(`Selected Return Date: ${selectedReturnDate}`);
      // Perform any actions with the selected return date here...
    });
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
              <q-input
                  filled
                  v-model="bookReturnDate"
                  label="Fecha de entrega"
                  type="date"
                  lazy-rules
                  :rules="[val => val && val.trim() !== '' || 'Debe seleccionar una fecha de entrega']"/>
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
