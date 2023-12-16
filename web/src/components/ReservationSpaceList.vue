<script lang="ts" setup>
import { onMounted, ref, computed } from "vue";
import { ReservationSpace } from "./types.ts";

const name = ref<string | null>(null);
const capacity = ref<number | null>(null);
const availability = ref<string | null>(null);

const API_URL = "http://localhost:3000/reservation_spaces";
const reservationSpaces = ref<ReservationSpace[]>([]);

const filterValue = ref('');

const itemsPerPage = ref(10);
const perPageOptions = [
  { label: '5', value: 5 },
  { label: '10', value: 10 },
  { label: '20', value: 20 }
];

const handleItemsPerPageChange = (value: number) => {
  itemsPerPage.value = value;
};

const paginatedReservationSpaces = computed(() => {
  const filteredSpaces = reservationSpaces.value.filter(reservationSpace =>
      reservationSpace.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredSpaces.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  reservationSpaces.value = data as ReservationSpace[];
});

const deleteReservationSpace = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  });
  reservationSpaces.value = reservationSpaces.value.filter(space => space.id !== id);
};

const editReservationSpace = async (id) => {
  const space = reservationSpaces.value.find(space => space.id === id);
  if (space) {
    spaceID.value = space.id;
    name.value = space.name;
    capacity.value = space.capacity;
    availability.value = space.availability;

    window.scroll({
      top: 0,
      behavior: 'smooth'
    });
  }
};

</script>

<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Lista de Espacios de Reserva</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar"
          >
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
              <tr>
                <th class="text-right">Nombre</th>
                <th class="text-right">Capacidad</th>
                <th class="text-right">Disponibilidad</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="space in paginatedReservationSpaces" :key="space.id">
              <tr>
                <td class="text-left">{{ space.name }}</td>
                <td class="text-left">{{ space.capacity }}</td>
                <td class="text-left">{{ space.availability }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editReservationSpace(space.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteReservationSpace(space.id)" class="small-btn"></q-btn>
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
  </q-layout>
</template>

<style scoped>

</style>
 