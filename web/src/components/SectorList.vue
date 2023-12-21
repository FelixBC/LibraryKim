<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Sector} from "./types.ts";
import EditNameModal from "./EditNameModal.vue";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/sectors";
const sectors = ref<Sector[]>([]);
const editingSector = ref<Sector | null>(null);
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

const paginatedSectors = computed(() => {
  const filteredSectors = sectors.value.filter(sector =>
      sector.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredSectors.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  sectors.value = data as Sector[];
});
const editSector = async (id) => {
  showModal.value = true;
  const sector = sectors.value.find(sector => sector.id === id)
  if (sector) {
    editingSector.value = sector;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onModalClose = () => {
  showModal.value = false;
};


const deleteSector = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  sectors.value = sectors.value.filter(person => person.id !== id)
}
const onUpdateSector = async ({id, name}) => {
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

  const index = sectors.value.findIndex(sector => sector.id === id);
  if (index !== -1) {
    sectors.value[index].name = data.name;
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
            <h4>Lista de Sectores</h4>
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
              <tbody v-for="sector in paginatedSectors" :key="sector.id">
              <tr>
                <td class="text-left">{{ sector.name }}</td>
                <td class="text-right">
                  <div>

                    <q-btn v-if="!showModal" round color="secondary" icon="edit" @click="editSector(sector.id)"
                           class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteSector(sector.id)"
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
    <EditNameModal v-model:show="showModal" v-bind="editingSector" @close="onModalClose"
                   @save="onUpdateSector"></EditNameModal>
  </q-layout>
</template>
<style scoped>
</style>