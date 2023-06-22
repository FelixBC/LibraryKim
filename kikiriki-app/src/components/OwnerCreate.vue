<script lang="ts" setup>
import {useQuasar} from 'quasar'
import {onMounted, ref} from 'vue'
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

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  owners.value = data as Owner[];
});

const createOwner = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name.value,
      age: age.value,
      lastName: lastName.value,
      phone: phone.value,
      city: city.value,
      identitificationNumber: identificationNumber.value,
      wins: wins.value,
      loses: loses.value,

    })
  })

  const data = await res.json()
  owners.value.push(data)
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
const updateOwner = async () => {
  const res = await fetch(`${API_URL}/${ownerId.value}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name.value,
      age: age.value,
      lastName: lastName.value,
      phone: phone.value,
      city: city.value,
      identitificationNumber: identificationNumber.value,
      wins: wins.value,
      loses: loses.value,
      id: ownerId.value
    })
  })
  const data = await res.json()
  const index = owners.value.findIndex(owner => owner.id === data.id)
  owners.value[index] = data
  name.value = ''
  lastName.value = ''
  phone.value = 0;
  ownerId.value = 0;
  name.value = ''
  age.value = 0;
  lastName.value = ''
  phone.value = 0;
  city.value = ''
  identificationNumber.value = 0;
  wins.value = 0;
  loses.value = 0;
  isEditing.value = false
}
const cancelEdit = () => {
  name.value = ''
  lastName.value = ''
  phone.value = 0;
  ownerId.value = 0;
  name.value = ''
  age.value = 0;
  lastName.value = ''
  phone.value = 0;
  city.value = ''
  identificationNumber.value = 0;
  wins.value = 0;
  loses.value = 0;
  isEditing.value = false
  ownerId.value = 0
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
    name.value = owner.name
    lastName.value = owner.lastName
    phone.value = owner.phone
    ownerId.value = owner.id
    isEditing.value = true

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
const onSubmit = () => {
  if (accept.value !== true) {
    $q.notify({
      color: 'red-5',
      textColor: 'white',
      icon: 'warning',
      message: 'You need to accept the license and terms first'
    })
  } else {
    $q.notify({
      color: 'green-4',
      textColor: 'white',
      icon: 'cloud_done',
      message: 'Submitted'
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
</script>

<template>
<div class="header_form">
  <h4>Crear Dueño</h4>
  <q-separator dark/>
</div>
  <q-card>
    <div class="div_form">
      <div class="q-pa-md" style="max-width: 400px">

        <q-form
            @submit="onSubmit"
            @reset="onReset"
            class="q-gutter-md"
        >
          <q-input
              filled
              v-model="name"
              label="Nombre *"
              hint="Jose"
              lazy-rules
              :rules="[ val => val && val.length > 0 || 'Debe escribir un nombre']"
          />
          <q-input
              filled
              v-model="lastName"
              label="Apellido *"
              hint="Rodriguez"
              lazy-rules
              :rules="[ val => val && val.length > 0 || 'Debe escribir un apellido']"
          />
          <q-input
              filled
              v-model="city"
              label="Ciudad *"
              hint="Santo Domigo"
              lazy-rules
              :rules="[ val => val && val.length > 0 || 'Debe escribir una ciudad']"
          />
          <q-input
              filled
              type="number"
              v-model="age"
              label="Edad *"
              lazy-rules
              :rules="[
          val => val !== null && val !== '' || 'Digite su edad',
          val => val > 0 && val < 100 || 'Por favor digite una edad real'
        ]"
          />
          <q-input
              filled
              type="number"
              v-model="identificationNumber"
              label="Cedula *"
              lazy-rules
              :rules="[
          val => val !== null && val !== '' || 'digite su cedula',
          val => val > 0 && val < 99999999999 || 'Por favor digite su cedula'
        ]"
          />
          <q-input
              filled
              type="number"
              v-model="phone"
              label="Telefono *"
              lazy-rules
              :rules="[
          val => val !== null && val !== '' || 'Digite su numero de telefono',
          val => val > 0 && val < 9999999999 || 'Por favor digite un telefono real'
        ]"
          />
          <q-input
              filled
              type="number"
              v-model="wins"
              label="Ganadas *"
              lazy-rules
              :rules="[
          val => val !== null && val !== '' || 'Por favor digite el numero de ganadas',
          val => val > 0 && val < 100 || 'Por favor digite un numero de ganadas real '
        ]"
          />
          <q-input
              filled
              type="number"
              v-model="loses"
              label="Perdidas *"
              lazy-rules
              :rules="[
          val => val !== null && val !== '' || 'Por favor digite numero de perdidas',
          val => val > 0 && val < 100 || 'Por favor digite un numero de perdidas'
        ]"
          />
          <q-toggle v-model="accept" label="I accept the license and terms"/>
          <q-card-actions align="right">

          </q-card-actions>
          <br>
          <div v-for="owner in owners" :key="owner.id">
            <h7>
              [{{ owner.name }} {{ owner.lastName }} {{ owner.age}} {{ owner.phone }} {{ owner.city}} {{ owner.identificationNumber}} {{ owner.wins }} {{owner.loses}} ]
            </h7>

            <q-btn @click="editOwner(owner.id)">Edit</q-btn>
            <q-btn @click="deleteOwner(owner.id)">Delete</q-btn>


          </div>

          <div>
            <q-btn color="primary" v-if="isEditing" @click="updateOwner">Update</q-btn>
            <q-btn color="primary" v-if="isEditing" @click="cancelEdit">Cancel</q-btn>
            <q-btn color="primary" v-else @click="createOwner">Create</q-btn>
            <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
          </div>

        </q-form>
      </div>
    </div>
  </q-card>

</template>

<style scoped>
.div_form{
  align-content: center;
  padding-left: 30%;
  padding-top: 5%;
  padding-bottom: 5%;
}

.header_form{
  padding-left: 35%;
  align-content: center;
}
</style>