<script lang="ts" setup>
import {onMounted, ref, computed} from "vue";
import {Employee} from "./types.ts";

const name = ref<string | null>(null)
const employee_ID = ref(0)
const API_URL = "http://localhost:3000/employees";
const employees = ref<Employee[]>([]);

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

const paginatedEmployees = computed(() => {
  const filteredEmployees = employees.value.filter(employee =>
      employee.name.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredEmployees.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  employees.value = data as Employee[];
});
const deleteEmployee = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  employees.value = employees.value.filter(person => person.id !== id)
}
const editEmployee = async (id) => {

  const employee = employees.value.find(employee => employee.id === id)
  if (employee) {
    employee_ID.value = employee.id
    name.value = employee.name

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
      <q-card class="full-width">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Lista de empleados</h4>
          </q-card-section>
          <q-input
              v-model.trim="filterValue"
              filled
              bottom-slots
              label="Buscar">
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
                  <th class="text-right">Telefono</th>
                  <th class="text-right">Salario</th>
                </tr>
              </thead>
              <tbody v-for="employee in paginatedEmployees" :key="employee.id">
                <tr>
                  <td class="text-left">{{ employee.name }}</td>
                  <td class="text-left">{{ employee.phoneNumber }}</td>
                  <td class="text-left">{{ employee.salary }}</td>
                  <td class="text-right">
                    <div>
                      <!-- pending -->
                      <!-- <q-btn round color="secondary" icon="edit" @click="editEmployee(employee.id)" class="small-btn"></q-btn>-->
                      <q-btn round color="secondary" icon="delete" @click="deleteEmployee(employee.id)"
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