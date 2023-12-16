<script lang="ts" setup>
import { onMounted, ref, computed } from "vue";
import { Event } from "./types.ts";

const name = ref<string | null>(null);
const dateEvent = ref<string| null>(null);
const timeEvent = ref<string | null>(null);
const currentDate = ref<string | null>(null);
const description = ref<string | null>(null);


const API_URL = "http://localhost:3000/events";
const events = ref<Event[]>([]);

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

const paginatedEvents = computed(() => {
  const filteredEvents = events.value.filter(event =>
      event.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredEvents.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  events.value = data as Event[];
});

const deleteEvent = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  });
  events.value = events.value.filter(event => event.id !== id);
};

const editEvent = async (id) => {
  const event = events.value.find(event => event.id === id);
  if (event) {
    eventID.value = event.id;
    name.value = event.name;
    dateEvent.value = event.dateEvent;
    timeEvent.value = event.timeEvent;
    currentDate.value = nevent.currentDate;
    description.value = event.description;

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
      <q-card class="full-width" style="max-width: 580px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Lista de Eventos</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar"
          >
            <template v-slot:prepend>
              <q-icon name="event"/>
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
                <th class="text-right">Fecha del Evento</th>
                <th class="text-right">Hora del Evento</th>
                <th class="text-right">Fecha de Registro</th>
                <th class="text-right">Descripcion</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="event in paginatedEvents" :key="event.id">
              <tr>
                <td class="text-left">{{ event.name }}</td>
                <td class="text-left">{{ event.dateEvent }}</td>
                <td class="text-left">{{ event.timeEvent }}</td>
                <td class="text-left">{{ event.currentDate }}</td>
                <td class="text-left">{{ event.description }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editEvent(event.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteEvent(event.id)" class="small-btn"></q-btn>
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
