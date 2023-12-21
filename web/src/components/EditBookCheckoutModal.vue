<!-- EditNameModal.vue -->
<template>
  <q-dialog :model-value="show">
    <q-card class="full-width">
      <q-card-section>
        <h1 class="text-h6">Editar Evento</h1>
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
      </q-card-section>
      <q-card-section>
        <h1 class="text-h6">Editar Cliente</h1>
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
      <q-card-section>
        <h1 class="text-h6">Editar Estado</h1>
        <q-select
            filled
            v-model="selectedValueStatus"
            bg-color="grey-4"
            label="Estado"
            option-value="id"
            option-label="name"
            :options="reservationStatuses"
            :filter="filterOptionsReservationStatuses"
            lazy-rules
            :rules="[ val => val && !val.isEmpty || 'Debe selectionar un estado']"/>
      </q-card-section>
      <q-card-actions align="right">
        <q-btn label="Cancel" color="secondary" @click="closeModal"/>
        <q-btn label="Save" color="primary" @click="saveChanges"/>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>
<script setup>
import { ref, toRefs, watch} from 'vue';

const props = defineProps(['id', 'eventId','clientId', 'statusId','events', 'clients', 'reservationStatuses', 'show']);
const {id, eventId, clientId, statusId, events, clients, reservationStatuses, show} = toRefs(props)
const emits = defineEmits(['save', 'update:show']);
const selectedValueEvents = ref(null);
const selectedValueClients = ref(null);
const selectedValueStatus = ref(null);
const filteredOptionsReservationStatuses = ref([]);

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

const filterOptionsReservationStatuses = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsReservationStatuses.value = reservationStatuses.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsReservationStatuses.value = reservationStatuses.value.filter(status => {
      const fullName = `${status.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

watch(show, (show) => {
  if (show) {
    selectedValueEvents.value = events.value.find(event => event.id === eventId.value);
    selectedValueClients.value = clients.value.find(client => client.id === clientId.value);
    selectedValueStatus.value = reservationStatuses.value.find(status => status.id === statusId.value);
  }
})


const closeModal = () => {
  emits('update:show', false);
};

const saveChanges = () => {
  emits('save', {
    id: props.id,
    eventId: selectedValueEvents.value.id,
    clientId: selectedValueClients.value.id,
    statusId: selectedValueStatus.value.id
  })
  closeModal();
};
</script>
<style scoped>
</style>
