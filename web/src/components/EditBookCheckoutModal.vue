<!-- EditNameModal.vue -->
import
<template>
  <q-dialog :model-value="show">
    <q-card class="full-width">
      <q-card-section>
        <h1 class="text-h6">Editar Libro</h1>
        <q-select
            filled
            v-model="selectedValueBooks"
            bg-color="grey-4"
            label="Book"
            option-value="id"
            option-label="name"
            :options="books"
            :filter="filterOptionsBooks"
            lazy-rules
            :rules="[ val => val && !val.isEmpty || 'Debe selectionar un libro']"/>
      </q-card-section>
      <q-card-section>
        <h1 class="text-h6">Editar Cliente</h1>
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
      <q-card-section>
        <h1 class="text-h6">Editar Estado</h1>
        <q-select
            filled
            v-model="selectedValueStatus"
            bg-color="grey-4"
            label="Estado"
            option-value="id"
            option-label="name"
            :options="bookCheckoutStatuses"
            :filter="filterOptionsBookCheckoutStatuses"
            lazy-rules
            :rules="[ val => val && !val.isEmpty || 'Debe selectionar un estado']"/>
      </q-card-section>
      <q-card-actions align="right">
        <q-btn label="Cancel" color="secondary" @click="closeModal"/>
        <q-btn label="Save" color="primary" @click="saveChanges"/>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>
<script setup>
import { ref, toRefs, watch} from 'vue';

const props = defineProps(['id', 'bookId', 'clientId', 'statusId', 'clients', 'books', 'bookCheckoutStatuses','show']);
const {id, bookId, clientId, statusId, books, clients, bookCheckoutStatuses, show} = toRefs(props)
const emits = defineEmits(['save', 'update:show']);
const selectedValueBooks = ref(null);
const selectedValueClients = ref(null);
const selectedValueStatus = ref(null);
const filteredOptionsBookCheckoutStatuses = ref([]);

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

const filterOptionsBookCheckoutStatuses = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsBookCheckoutStatuses.value = bookCheckoutStatuses.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsBookCheckoutStatuses.value = bookCheckoutStatuses.value.filter(status => {
      const fullName = `${status.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

watch(show, (show) => {
  if (show) {
    selectedValueBooks.value = books.value.find(book => book.id === bookId.value);
    selectedValueClients.value = clients.value.find(client => client.id === clientId.value);
    selectedValueStatus.value = bookCheckoutStatuses.value.find(status => status.id === statusId.value);
  }
})


const closeModal = () => {
  emits('update:show', false);
};

const saveChanges = () => {
  emits('save', {
    id: props.id,
    bookId: selectedValueBooks.value.id,
    clientId: selectedValueClients.value.id,
    statusId: selectedValueStatus.value.id
  })
  closeModal();
};
</script>
<style scoped>
</style>
