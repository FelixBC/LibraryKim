<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {SupplierType} from "./types.ts";

const name = ref<string | null>(null)
const supplierType_ID = ref(0)
const API_URL = "http://localhost:3000/supplier_types";
const supplierTypes = ref<SupplierType[]>([]);

const filterValue = ref('')

const itemsPerPage = ref(10);
const perPageOptions = [
  {label: '5', value: 5},
  {label: '10', value: 10},
  {label: '20', value: 20}
];

const handleItemsPerPageChange = (value: number) => {
  itemsPerPage.value = value;
};

const paginatedSupplierTypes = computed(() => {
  const filteredSupplierTypes = supplierTypes.value.filter(supplierType =>
      supplierType.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredSupplierTypes.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  supplierTypes.value = data as SupplierType[];
});
const deleteSupplierType = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  supplierTypes.value = supplierTypes.value.filter(person => person.id !== id)
}
const editSupplierType = async (id) => {

  const supplierType = supplierTypes.value.find(supplierType => supplierType.id === id)
  if (supplierType) {
    supplierType_ID.value = supplierType.id
    name.value = supplierType.name

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}


</script>
<template>
  <q-layout>
    <q-page class="flex-md-center" padding>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Lista de Tipos de Suplidores</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar"
          >
            <template v-slot:before>
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
              <tr>
                <th class="text-right">Nombre</th>
                <th></th>
                <th></th>
              </tr>
              </thead>
              <tbody v-for="supplierType in paginatedSupplierTypes" :key="supplierType.id">
              <tr>
                <td class="text-left">{{ supplierType.name }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editSupplierType(supplierType.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteSupplierType(supplierType.id)"
                           class="small-btn"></q-btn>
                  </div>
                </td>
                <th></th>
              </tr>
              </tbody>
              <div>
              </div>
            </q-markup-table>
          </q-card>
        </q-card-section>
      </q-card>
    </q-page>
  </q-layout>
</template>
<style scoped>

</style>