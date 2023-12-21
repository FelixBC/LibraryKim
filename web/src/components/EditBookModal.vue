<!-- EditNameModal.vue -->
<template>
  <q-dialog :model-value="show">
    <q-card>
      <q-card-section>
        <q-card-title class="text-h6">Editar Titulo {{ localTitle }}</q-card-title>
        <q-input v-model="localTitle" filled label="Nuevo titulo"></q-input>
      </q-card-section>
      <q-card-section>
        <q-card-title class="text-h6">Editar Precio {{ localPrice }}</q-card-title>
        <q-input v-model="localPrice" filled label="Nuevo precio"></q-input>
      </q-card-section>
      <q-card-section>
        <q-card-title class="text-h6">Editar Cantidad {{ localQuantity }}</q-card-title>
        <q-input v-model="localQuantity" filled label="Nueva cantidad"></q-input>
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

const props = defineProps(['id', 'title','price','quantity',  'show']);
const {id, title, price, quantity, show} = toRefs(props)
const emits = defineEmits(['save', 'update:show']);
const localTitle = ref(null);
const localPrice = ref(null);
const localQuantity = ref(null);

watch(show, (show) => {
  if (show) {
    localTitle.value = title.value;
    localPrice.value = price.value;
    localQuantity.value = quantity.value;
  }
})


const closeModal = () => {
  emits('update:show', false);
};

const saveChanges = () => {
  emits('save', {id: props.id, title: localTitle.value, price: localPrice.value, quantity: localQuantity.value})
  closeModal();
};
</script>
<style scoped>
</style>
