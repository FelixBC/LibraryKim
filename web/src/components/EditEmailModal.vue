<!-- EditEmailModal.vue -->
<template>
  <q-dialog :model-value="show">
    <q-card>
      <q-card-section>
        <q-card-title class="text-h6">Edit Email {{ localEmail }}</q-card-title>
        <q-input v-model="localEmail" filled label="Email"></q-input>
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

const props = defineProps(['id', 'email', 'show']);
const {id, email, show} = toRefs(props)
const emits = defineEmits(['save', 'update:show']);
const localEmail = ref(null);

watch(show, (show) => {
  if (show) {
    localEmail.value = email.value;
  }
})


const closeModal = () => {
  emits('update:show', false);
};

const saveChanges = () => {
  emits('save', {id: props.id, email: localEmail.value});
  closeModal();
};
</script>
<style scoped>
</style>
