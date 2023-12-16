<script lang="ts" setup>
import { onMounted, ref, computed } from "vue";
import { Reservation } from "./types.ts";

const eventID = ref<number | null>(null);
const clientID = ref<number | null>(null);
const status = ref<string | null>(null);

const API_URL = "http://localhost:3000/reservations";
const reservations = ref<Reservation[]>([]);

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

const paginatedReservations = computed(() => {
  const filteredReservations = reservations.value.filter(reservation =>
      reservation.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredReservations.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  reservations.value = data as Reservation[];
});

const deleteReservation = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  });
  reservations.value = reservations.value.filter(reservation => reservation.id !== id);
};

const editReservation = async (id) => {
  const reservation = reservations.value.find(reservation => reservation.id === id);
  if (reservation) {
    eventID.value = reservation.eventID;
    clientID.value = reservation.clientID;
    status.value = reservation.status;

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
            <h4>Lista de Reservas</h4>
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
                <th class="text-right">ID de Evento</th>
                <th class="text-right">ID de Cliente</th>
                <th class="text-right">Estado</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="reservation in paginatedReservations" :key="reservation.id">
              <tr>
                <td class="text-left">{{ reservation.eventID }}</td>
                <td class="text-left">{{ reservation.clientID }}</td>
                <td class="text-left">{{ reservation.status }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editReservation(reservation.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteReservation(reservation.id)" class="small-btn"></q-btn>
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
