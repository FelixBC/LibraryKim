<!-- EditNameModal.vue -->
<template>
  <q-dialog :model-value="show">
    <q-card class="full-width">
      <q-card-section>
        <h1 class="text-h6">Editar nombre</h1>
        <q-input v-model="localName" filled label="Nuevo nombre"></q-input>
      </q-card-section>
      <q-card-section>
        <h1 class="text-h6">Editar fecha</h1>
        <q-input v-model="localEventDate" filled label="Nueva fecha del evento"></q-input>
      </q-card-section>
      <q-card-section>
        <h1 class="text-h6">Editar descripcion</h1>
        <q-input v-model="localDescription" filled label="Nueva descripcion"></q-input>
      </q-card-section>
      <q-card-section>
        <h1 class="text-h6">Editar URL de imagen </h1>
        <q-input v-model="localImageUrl" filled label="Nueva Url de imagen"></q-input>
      </q-card-section>
      <q-card-section>
        <h1 class="text-h6">Editar capacidad</h1>
        <q-input v-model="localCapacity" filled label="Nueva capacidad"></q-input>
      </q-card-section>
      <q-card-actions align="right">
        <q-btn label="Cancel" color="secondary" @click="closeModal"/>
        <q-btn label="Save" color="primary" @click="saveChanges"/>
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>
<script setup>
import {ref, toRefs, watch} from 'vue';

const props = defineProps(['id', 'name', 'eventDate', 'description', 'imageUrl', 'capacity', 'show']);
const {id, name, eventDate, description, imageUrl, capacity, show} = toRefs(props)
const emits = defineEmits(['save', 'update:show']);
const localName = ref(null);
const localEventDate = ref(null);
const localDescription = ref(null);
const localImageUrl = ref(null);
const localCapacity = ref(null);

watch(show, (show) => {
  if (show) {
    localName.value = name.value;
    localEventDate.value = eventDate.value;
    localDescription.value = description.value;
    localImageUrl.value = imageUrl.value;
    localCapacity.value = capacity.value;
  }
})


const closeModal = () => {
  emits('update:show', false);
};

const saveChanges = () => {
  emits('save', {
    id: props.id,
    name: localName.value,
    eventDate: localEventDate.value,
    description: localDescription.value,
    imageUrl: localImageUrl.value,
    capacity: localCapacity.value

  })
  closeModal();
};
</script>
<style scoped>
</style>
