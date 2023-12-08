<!-- EditNameModal.vue -->
<template>
  <q-dialog v-model="showModal">
    <q-card>
      <q-card-section>
        <q-card-title class="text-h6">Edit Name</q-card-title>
        <q-input v-model.trim="editedName" filled label="Name"></q-input>
      </q-card-section>
      <q-card-actions align="right">
        <q-btn label="Cancel" color="secondary" @click="closeModal" />
        <q-btn label="Save" color="primary" @click="saveChanges" />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>
<script setup>
import { ref, defineProps, defineEmits } from 'vue';

const { editedName: propEditedName } = defineProps(['editedName']);
const emits = defineEmits(['save']);

const showModal = ref(true);
const editedName = ref(propEditedName);

const closeModal = () => {
  showModal.value = false;

  //show the edit button again


};

const saveChanges = () => {
  emits('save', editedName.value);
  closeModal();
};


</script>

<style scoped>
/* Add styles if needed */
</style>
