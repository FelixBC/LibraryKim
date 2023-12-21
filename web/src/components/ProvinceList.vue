<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Province} from "./types.ts";
import EditNameModal from "./EditNameModal.vue";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/provinces";
const provinces = ref<Province[]>([]);
const editingProvince = ref<Province | null>(null);
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

const paginatedProvinces = computed(() => {
  const filteredProvinces = provinces.value.filter(province =>
      province.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredProvinces.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  provinces.value = data as Province[];
});
const editProvince = async (id) => {
  showModal.value = true;
  const province = provinces.value.find(province => province.id === id)
  if (province) {
    editingProvince.value = province;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onModalClose = () => {
  showModal.value = false;
};


const deleteProvince = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  provinces.value = provinces.value.filter(person => person.id !== id)
}
const onUpdateProvince = async ({id, name}) => {
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

  const index = provinces.value.findIndex(province => province.id === id);
  if (index !== -1) {
    provinces.value[index].name = data.name;
  }

  showModal.value = false;
};

</script>
<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Lista de provincias</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots label="Buscar"
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
              <tbody v-for="province in paginatedProvinces" :key="province.id">
              <tr>
                <td class="text-left">{{ province.name }}</td>
                <td class="text-right">
                  <div>

                    <q-btn v-if="!showModal" round color="secondary" icon="edit" @click="editProvince(province.id)"
                           class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteProvince(province.id)"
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
    <EditNameModal v-model:show="showModal" v-bind="editingProvince" @close="onModalClose"
                   @save="onUpdateProvince"></EditNameModal>
  </q-layout>
</template>
<style scoped>

</style>
/style>