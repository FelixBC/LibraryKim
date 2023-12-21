<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Reservation, ReservationStatus} from "./types.ts";
import EditReservationModal from "./EditReservationModal.vue";
import EditEventModal from "./EditEventModal.vue";

const eventID = ref<number | null>(null);
const clientID = ref<number | null>(null);
const status = ref<string | null>(null);

const API_URL = "http://localhost:3000/reservations";
const EVENTS_API_URL = "http://localhost:3000/events";
const CLIENTS_API_URL = "http://localhost:3000/users?role=client";
const STATUSES_API_URL = "http://localhost:3000/reservations/general_params";

const reservations = ref<Reservation[]>([]);
const events = ref<Event[]>([]);
const clients = ref<Client[]>([]);
const reservationStatuses = ref<ReservationStatus[]>([]);
const editingReservation = ref<Reservation | null>(null);

const filterValue = ref('');

const itemsPerPage = ref(10);
const perPageOptions = [
  {label: '5', value: 5},
  {label: '10', value: 10},
  {label: '20', value: 20}
];

const showModal = ref(false);
const handleItemsPerPageChange = (value: number) => {
  itemsPerPage.value = value;
};

const paginatedReservations = computed(() => {
  const filteredReservations = reservations.value.filter(reservation =>
      displayEvent(reservation.eventId).toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredReservations.slice(0, itemsPerPage.value);
});

const fetchReservations = async () => {
  try {
    const response = await fetch(API_URL);
    if (!response.ok) {
      throw new Error('Failed to fetch reservations');
    }
    reservations.value = await response.json();
    console.log(reservations.value);
  } catch (error) {
    console.error('Error fetching reservations:', error);
  }
};
const fetchEvents = async () => {
  try {
    const response = await fetch(EVENTS_API_URL);
    if (!response.ok) {
      throw new Error('Failed to fetch events');
    }
    events.value = await response.json();
    console.log(events.value);
  } catch (error) {
    console.error('Error fetching events:', error);
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

const onUpdateReservation = async ({id, eventId, clientId, statusId}) => {
  debugger;
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      reservation: {
        eventId: eventId,
        clientId: clientId,
        statusId: statusId
      }
    })
  });
  const data = await res.json();
  const index = reservations.value.findIndex(reservation => reservation.id === id);

  if (index !== -1) {
    reservations.value[index].eventId = data.eventId;
    reservations.value[index].clientId = data.clientId;
    reservations.value[index].statusId = data.statusId;
  }

  showModal.value = false;
};

const fetchStatuses = async () => {
  try {
    const response = await fetch(STATUSES_API_URL)
    if (!response.ok) {
      throw new Error('Failed to fetch statuses');
    }
    reservationStatuses.value = await response.json();
    console.log(reservationStatuses.value);
  } catch (error) {
    console.error('Error fetching statuses:', error);
  }
};


onMounted(async () => {
  await fetchReservations();
  await fetchEvents();
  await fetchClients();
  await fetchStatuses();
});

const deleteReservation = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  });
  reservations.value = reservations.value.filter(reservation => reservation.id !== id);
};

const editReservation = async (id) => {
  const reservation = reservations.value.find(reservation => reservation.id === id);
  showModal.value = true;
  if (reservation) {
    editingReservation.value = reservation
    window.scroll({
      top: 0,
      behavior: 'smooth'
    });
  }
};

const displayEvent = (id) => {
  const event = events.value.find(event => event.id === id);
  if (event) {
    return event.name;
  } else {
    return '';
  }
};
const displayClient = (id) => {
  const client = clients.value.find(client => client.id === id);
  if (client) {
    return client.email;
  }
};

const displayStatus = (id) => {
  const status = reservationStatuses.value.find(status => status.id === id);
  if (status) {
    return status.name;
  }
};

</script>

<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Lista de Reservas</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar">
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
                <tr class="text-center">
                  <th>Evento</th>
                  <th>Cliente</th>
                  <th>Estado</th>
                  <th></th>
                  <th></th>
                </tr>
              </thead>
              <tbody v-for="reservation in paginatedReservations" :key="reservation.id">
                <tr class="text-center">
                  <td>{{ displayEvent(reservation.eventId) }}</td>
                  <td>{{ displayClient(reservation.clientId) }}</td>
                  <td>{{ displayStatus(reservation.statusId) }}</td>
                  <td class="text-right">
                    <div>
                      <q-btn round color="secondary" icon="edit" @click="editReservation(reservation.id)"
                             class="small-btn"></q-btn>
                      <q-btn round color="secondary" icon="delete" @click="deleteReservation(reservation.id)"
                             class="small-btn"></q-btn>
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
    <EditReservationModal v-model:show="showModal"
                          v-bind="editingReservation"
                          :events="events"
                          :clients="clients"
                          :reservationStatuses="reservationStatuses"
                          @save="onUpdateReservation"
                          @hide="showModal = false" />
  </q-layout>
</template>

<style scoped>

</style>
