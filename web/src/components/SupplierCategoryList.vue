<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {SupplierCategory} from "./types.ts";

const name = ref<string | null>(null)
const supplierCategory_ID = ref(0)
const API_URL = "http://localhost:3000/supplier_categories";
const supplierCategories = ref<SupplierCategory[]>([]);

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

const paginatedSupplierCategories = computed(() => {
  const filteredSupplierCategories = supplierCategories.value.filter(supplierCategory =>
      supplierCategory.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredSupplierCategories.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  supplierCategories.value = data as SupplierCategory[];
});
const deleteSupplierCategory = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  supplierCategories.value = supplierCategories.value.filter(person => person.id !== id)
}
const editSupplierCategory = async (id) => {

  const supplierCategory = supplierCategories.value.find(supplierCategory  => supplierCategory.id === id)
  if (supplierCategory ) {
    supplierCategory_ID.value = supplierCategory.id
    name.value = supplierCategory.name

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
            <h4>Lista de Categorias de Suplidores</h4>
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
              <tbody v-for="supplierCategory in paginatedSupplierCategories" :key="supplierCategory.id">
              <tr>
                <td class="text-left">{{ supplierCategory.name }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editSupplierCategory (supplierCategory.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteSupplierCategory (supplierCategory.id)"
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