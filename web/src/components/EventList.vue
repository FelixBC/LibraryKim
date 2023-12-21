<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Event} from "./types.ts";
import EditEventModal from "./EditEventModal.vue";
import {useRouter} from "vue-router";

const name = ref<string | null>(null);
const editingEvent = ref<Event | null>(null);
const showModal = ref(false);
const API_URL = "http://localhost:3000/events";
const events = ref<Event[]>([]);
const filterValue = ref('');
const itemsPerPage = ref(10);
const perPageOptions = [
  {label: '5', value: 5},
  {label: '10', value: 10},
  {label: '20', value: 20}
];
const router = useRouter();

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
  showModal.value = true;
  const event = events.value.find(event => event.id === id);
  if (event) {
    editingEvent.value = event

    window.scroll({
      top: 0,
      behavior: 'smooth'
    });
  }
};

const onUpdateEvent = async ({id, name, eventDate, description, imageUrl, capacity}) => {
  const res = await fetch(`${API_URL}/${id}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      event: {
        name,
        eventDate,
        description,
        imageUrl,
        capacity
      }
    })
  });
  const data = await res.json();
  const index = events.value.findIndex(event => event.id === id);
  const currentPath = router.currentRoute.value.fullPath;

  if (index !== -1) {
    events.value[index].name = data.name;
  }

  showModal.value = false;
  router.replace({path: '/redirect', query: {to: currentPath}}).then(() => {
    router.replace({path: currentPath});
  });
};

</script>

<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Lista de Eventos</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar">
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
                <tr class="text-center">
                  <th>Nombre</th>
                  <th>Fecha del Evento</th>
                  <th>Descripcion</th>
                  <th>Imagen</th>
                  <th>Capacity</th>
                </tr>
              </thead>
              <tbody v-for="event in paginatedEvents" :key="event.id">
                <tr class="text-center">
                  <td>{{ event.name }}</td>
                  <td>{{ event.eventDate }}</td>
                  <td>{{ event.description }}</td>
                  <td>
                    <q-img class="rounded-borders col-6 " :src="event.imageUrl" width="120px"/>
                  </td>
                  <td>{{ event.capacity }}</td>
                  <td class="text-right">
                    <div>
                      <q-btn round color="secondary" icon="edit" @click="editEvent(event.id)" class="small-btn"></q-btn>
                      <q-btn round color="secondary" icon="delete" @click="deleteEvent(event.id)"
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
    <EditEventModal v-model:show="showModal" v-bind="editingEvent" @hide="showModal = false;"
                   @save="onUpdateEvent"></EditEventModal>
  </q-layout>
</template>

<style scoped>

</style>
