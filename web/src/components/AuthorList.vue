<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Author} from "./types.ts";
import EditNameModal from "./EditNameModal.vue";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/authors";
const authors = ref<Author[]>([]);
const editingAuthor = ref<Author | null>(null);
const showModal = ref(false);
const filterValue = ref('')
const itemsPerPage = ref(10);
// not needed could implement later
// const perPageOptions = [
//   {label: '5', value: 5},
//   {label: '10', value: 10},
//   {label: '20', value: 20}
// ];
//
// const handleItemsPerPageChange = (value: number) => {
//   itemsPerPage.value = value;
// };

const paginatedAuthors = computed(() => {
  const filteredAuthors = authors.value.filter(author =>
      author.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredAuthors.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  authors.value = data as Author[];
});
const editAuthor = async (id) => {
  showModal.value = true;
  const author = authors.value.find(author => author.id === id)
  if (author) {
    editingAuthor.value = author;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onModalClose = () => {
  showModal.value = false;
};


const deleteAuthor = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  authors.value = authors.value.filter(person => person.id !== id)
}
const onUpdateAuthor = async ({id, name}) => {
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name,
    })
  });

  const data = await res.json();

  const index = authors.value.findIndex(author => author.id === id);
  if (index !== -1) {
    authors.value[index].name = data.name;
  }

  showModal.value = false;
};

</script>
<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Lista de Autores</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar"
          >
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
              <tr>
                <th class="text-right">Nombre</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="author in paginatedAuthors" :key="author.id">
              <tr>
                <td class="text-left">{{ author.name }}</td>
                <td class="text-right">
                  <div>

                    <q-btn v-if="!showModal" round color="secondary" icon="edit" @click="editAuthor(author.id)"
                           class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteAuthor(author.id)"
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
    <EditNameModal v-model:show="showModal" v-bind="editingAuthor" @close="onModalClose"
                   @save="onUpdateAuthor"></EditNameModal>
  </q-layout>
</template>
<style scoped>

</style>