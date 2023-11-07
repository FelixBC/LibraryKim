<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Author} from "./types.ts";

const name = ref<string | null>(null)
const author_ID = ref(0)
const API_URL = "http://localhost:3000/authors";
const authors = ref<Author[]>([]);

const filterValue = ref('')

const itemsPerPage = ref(10);
const perPageOptions = [
  {label: '5', value: 5},
  {label: '10', value: 10},
  {label: '20', value: 20}
];

const handleItemsPerPageChange = (value: number) => {
  itemsPerPage.value = value;
};

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
const deleteAuthor = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  authors.value = authors.value.filter(person => person.id !== id)
}
const editAuthor = async (id) => {

  const author = authors.value.find(author => author.id === id)
  if (author) {
    author_ID.value = author.id
    name.value = author.name

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}


</script>
<template>
    <h4> Lista Autores </h4>
  <q-page padding>
    <q-card-section class="flex">
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
              <q-btn round color="secondary" icon="edit" @click="editAuthor(author.id)" class="small-btn"></q-btn>
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
  </q-page>
</template>
<style scoped>

</style>