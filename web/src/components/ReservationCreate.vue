<script lang="ts" setup>
import {onMounted, ref} from 'vue';
import {Reservation} from "./types.ts";
import {useRouter} from "vue-router";

const status = ref<string | null>(null);
const selectedValueEvents = ref<string | null>(null);
const selectedValueClients = ref<string | null>(null);
const events = ref<Event[]>([]);
const clients = ref<Client[]>([]);

const API_URL = "http://localhost:3000/reservations";
const EVENTS_API_URL = "http://localhost:3000/events";
const CLIENTS_API_URL = "http://localhost:3000/users?role=client";
const reservations = ref<Reservation[]>([]);
const router = useRouter();

const createReservation = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      reservation: {
        eventId: selectedValueEvents.value.id,
        clientId: selectedValueClients.value.id,
        status: status.value,
      }
    })
  });

  const data = await res.json();
  reservations.value.push(data);
await router.push('/reservations');

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
    const response = await fetch(CLIENTS_API_URL,{
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

const filterOptionsEvents = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsEvents.value = events.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsEvents.value = events.value.filter(event => {
      const fullName = `${event.name}`.toLowerCase();
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
  fetchEvents();
  fetchClients();
});


</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Crear Reserva</h4>
          </q-card-section>
          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-select
                    filled
                    v-model="selectedValueEvents"
                    bg-color="grey-4"
                    label="Event"
                    option-value="id"
                    option-label="name"
                    :options="events"
                    :filter="filterOptionsEvents"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe selectionar un evento']"/>
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
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createReservation">Crear Reserva</q-btn>
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
