<script setup lang="ts">
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
      identificationNumber: identificationNumber.value,
      wins: wins.value,
      loses: loses.value,
    })
  })

  const data = await res.json()
  owners.value.push(data)
  onReset()
}
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
  <h4>Crear Pelea</h4>
  <q-separator dark/>
   <q-card>
     <q-form>
       <div class="form-columns">
         <div class="form-column">
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
         </div>
         <div class="column">
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
         </div>
       </div>
       <div class="divButtons">
         <q-btn color="primary" @click="createOwner">Create</q-btn>
         <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
       </div>

     </q-form>
   </q-card>

</template>

<style scoped>
</style>