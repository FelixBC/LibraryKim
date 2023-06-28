<script setup lang="ts">
import {useQuasar} from 'quasar'
import {onMounted, computed, ref} from 'vue'
import {Owner} from "./types.ts";

const $q = useQuasar()

const name = ref<string | null>(null)
const lastName = ref<string | null>(null)
const city = ref<string | null>(null)
const age = ref<number | null>(null)
const identificationNumber = ref<number | null>(null)
const phone = ref<number | null>(null)
const wins = ref<number | null>(null)
const loses = ref<number | null>(null)
const accept = ref(false)
const owners = ref<Owner[]>([])
const ownerId = ref(0)
const isEditing = ref(false)
const API_URL = "http://localhost:3000/owners";
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

const paginatedOwners = computed(() => {
  const filteredOwners = owners.value.filter(owner =>
      owner.name.toLowerCase().includes(filterValue.value.toLowerCase()) ||
      owner.lastName.toLowerCase().includes(filterValue.value.toLowerCase()) ||
      owner.city.toLowerCase().includes(filterValue.value.toLowerCase())
  );

  return filteredOwners.slice(0, itemsPerPage.value);
});

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  owners.value = data as Owner[];
});


const updateOwner = async () => {
  const res = await fetch(`${API_URL}/${ownerId.value}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      id: ownerId.value,
      name: name.value,
      age: age.value,
      lastName: lastName.value,
      phone: phone.value,
      city: city.value,
      identificationNumber: identificationNumber.value,
      wins: wins.value,
      loses: loses.value,

    })
  })
  const data = await res.json()
  const index = owners.value.findIndex(owner => owner.id === data.id)
  owners.value[index] = data
  onReset()
}
const cancelEdit = () => {
  onReset()
  isEditing.value = false
}
const deleteOwner = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  owners.value = owners.value.filter(person => person.id !== id)
}
const editOwner = async (id) => {

  const owner = owners.value.find(owner => owner.id === id)
  if (owner) {
    ownerId.value = owner.id
    name.value = owner.name
    age.value = owner.age
    lastName.value = owner.lastName
    phone.value = owner.phone
    city.value = owner.city
    identificationNumber.value = owner.identificationNumber
    wins.value = owner.wins
    loses.value = owner.loses
    isEditing.value = true

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onReset = () => {
  name.value = null
  lastName.value = null
  age.value = null
  city.value = null
  identificationNumber.value = null
  phone.value = null
  wins.value = null
  loses.value = null
  accept.value = false

}
const onItemClick = () => {
  return true
}
const truncateText = (text, maxLength) => {
  if (text && text.length > maxLength) {
    return text.slice(0, maxLength) + "..." + "" + "";
  }
  return text;
}


</script>

<template>
  <div class="divCenterEverything">
  <div class="cardContainer">
    <q-card>

      <div>
        <div class="divHeader">
          <h4>Lista dueños </h4>
          <q-separator dark/>
        </div>

        <div class="inputSearch">
          <div class="btnEntradaPorPagina">

            <q-btn-toggle
                v-model="itemsPerPage"
                color="primary"
                dense
                options-dense
                :options="perPageOptions"
                @change="handleItemsPerPageChange"
            />


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
          </div>
        </div>
        <div class="my-card">
          <q-card flat bordered>

            <q-markup-table>
              <thead>

              <tr>

                <th class="text-right">Nombre</th>
                <th class="text-right">Apellido</th>
                <th class="text-right">Ciudad</th>
                <th class="text-right">Telefono</th>
                <th class="text-right">Cedula</th>
                <th class="text-right">promedio de bajas</th>
                <th class="text-right">Opciones</th>
              </tr>
              </thead>
              <tbody v-for="owner in paginatedOwners" :key="owner.id">
              <tr>
                <td  class="text-left truncate-cell">{{ truncateText(owner.name, 5) }}</td>
                <td class="text-right truncate-cell">{{ truncateText(owner.lastName, 6) }}</td>
                <td class="text-right truncate-cell">{{ owner.city }}</td>
                <td class="text-right truncate-cell">{{ owner.phone }}</td>
                <td class="text-right truncate-cell">{{ owner.identificationNumber }}</td>
                <!-- CalculateWinFrequency formula: wins / total of the games played * 100 -->
                <td class="text-right">{{ (((owner.wins / (owner.wins + owner.loses))) * 100).toFixed(1) + "%" }}</td>
                <td class="text-right">
                  <div>
                    <q-btn round color="secondary" icon="edit" @click="editOwner(owner.id)" class="small-btn"></q-btn>
                    <q-btn round color="secondary" icon="delete" @click="deleteOwner(owner.id)"
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

        </div>
      </div>
    </q-card>

  </div>
  </div>
</template>

<style scoped>

.truncate-cell {
  max-width: 100px; /* Adjust the width as needed */
  white-space: nowrap;
  overflow: hidden;
}
.divCenterEverything{
  display: flex;
  justify-content: center;
  align-content: center;
  align-items: center;
  align-self: center;
}
.my-card {
  width: 90%;
  margin-left: 5%;
  padding-bottom: 30%;
}

.cardContainer {
  width: 45%;
  justify-content: center;
  flex-direction: column;
  align-items: center;
}

.divHeader {
  padding-top: 5%;
  text-align: center;
}
.onHover{
 width: 120%;
}
.inputSearch {
  margin-left: 60%;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 5px;
}

.small-btn {
  font-size: 82%; /* Adjust the font size as needed */
  padding: 5%; /* Adjust the padding as needed */
}

.btnEntradaPorPagina {
 display: flex;
}

th {
  padding-left: 5%;

}

td {
  margin: 5%;
  padding: 5%;
}

.hoverable{
  width: 120%; /* Adjust the width as needed */
  transition: width 0.3s; /* Add transition for smooth animation */
}


.ellipsis-with-min-width .q-item-label {
  display: -webkit-box; /* Enable the use of flexbox for text truncation */
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1; /* Number of lines to show before truncation */
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>