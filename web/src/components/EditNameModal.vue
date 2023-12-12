<!-- EditNameModal.vue -->
<template>
  <q-dialog :model-value="show">
    <q-card>
      <q-card-section>
        <q-card-title class="text-h6">Edit Name {{ localName }}</q-card-title>
        <q-input v-model="localName" filled label="Name"></q-input>
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

const props = defineProps(['id', 'name', 'show']);
const {id, name, show} = toRefs(props)
const emits = defineEmits(['save', 'update:show']);
const localName = ref(null);

watch(show, (show) => {
  if (show) {
    localName.value = name.value;
  }
})


const closeModal = () => {
  emits('update:show', false);
};

const saveChanges = () => {
  emits('save', {id: props.id, name: localName.value});
  closeModal();
};
</script>
<style scoped>
</style>
