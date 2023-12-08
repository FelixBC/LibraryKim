<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {City} from "./types.ts";

const name = ref<string | null>(null)
const city_ID = ref(0)
const API_URL = "http://localhost:3000/cities";
const cities = ref<City[]>([]);

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

const paginatedCitys = computed(() => {
  const filteredCitys = cities.value.filter(city =>
      city.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredCitys.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  cities.value = data as City[];
});
const deleteCity = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  cities.value = cities.value.filter(person => person.id !== id)
}
const editCity = async (id) => {

  const city = cities.value.find(city => city.id === id)
  if (city) {
    city_ID.value = city.id
    name.value = city.name

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}


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
              <tbody v-for="city in paginatedCitys" :key="city.id">
              <tr>
                <td class="text-left">{{ city.name }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editCity(city.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteCity(city.id)"
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
  </q-layout>
</template>
<style scoped>

</style>