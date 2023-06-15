<template>
  <q-page>
    <q-card class="q-ma-md">
      <q-card-section>

        <h4> Just a regular header of a test form:
          What's up I'm the about page info tester
        </h4>
        <q-input
            outlined
            v-model="firstName"
            type="text"
            label="First Name"
            required
        ></q-input>

        <q-input
            outlined
            v-model="lastName"
            label="Last Name"
            required
        ></q-input>
        <q-input
            outlined
            v-model="phoneNumber"
            label="Phone"

            require of a test formd

        ></q-input>

      </q-card-section>
      <q-card-actions align="right">
        <q-btn color="primary" v-if="isEditing" @click="updatePerson">Update</q-btn>
        <q-btn color="primary" v-if="isEditing" @click="cancelEdit">Cancel</q-btn>
        <q-btn color="primary" v-else @click="createPerson">Create</q-btn>
      </q-card-actions>
      <br>
      <div v-for="person in persons" :key="person.id">
        <h7>
          [{{ person.firstName }} {{ person.lastName }} {{ person.phoneNumber }} ]
        </h7>

        <q-btn @click="editPerson(person.id)">Edit</q-btn>
        <q-btn @click="deletePerson(person.id)">Delete</q-btn>


      </div>

    </q-card>
  </q-page>
</template>
<script lang="ts" setup>
import {ref, onMounted} from 'vue';
import {Person} from "./types.ts";

// Declare and initialize your data using the `ref()` function
const firstName = ref('');
const lastName = ref('');
const phoneNumber = ref('');
const persons = ref<Person[]>([])
const personId = ref(0)
const isEditing = ref(false)
const API_URL = "http://localhost:3000/people";

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  persons.value = data as Person[];
});

const createPerson = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      firstName: firstName.value,
      lastName: lastName.value,
      phoneNumber: phoneNumber.value
    })
  })

  const data = await res.json()

  persons.value.push(data)
  firstName.value = ''
  lastName.value = ''
  phoneNumber.value = ''
  personId.value = 0;
}
const updatePerson = async () => {
  const res = await fetch(`${API_URL}/${personId.value}`, {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      firstName: firstName.value,
      lastName: lastName.value,
      phoneNumber: phoneNumber.value,
      id: personId.value
    })
  })
  const data = await res.json()
  const index = persons.value.findIndex(person => person.id === data.id)
  persons.value[index] = data
  firstName.value = ''
  lastName.value = ''
  phoneNumber.value = ''
  isEditing.value = false
}
const cancelEdit = () => {
  firstName.value = ''
  lastName.value = ''
  phoneNumber.value = ''
  isEditing.value = false
  personId.value = 0
}
const deletePerson = async (id) => {
  await fetch(`${API_URL}/${id}`, {
    method: 'DELETE'
  })
  persons.value = persons.value.filter(person => person.id !== id)
}
const editPerson = async (id) => {

  const person = persons.value.find(person => person.id === id)
  if (person) {
    firstName.value = person.firstName
    lastName.value = person.lastName
    phoneNumber.value = String(person.phoneNumber)
    personId.value = person.id
    isEditing.value = true

    window.scroll({
      top: 0,
      behavior: 'smooth'
    })
  }
}
</script>

<style>
h7 {
  position: relative;
  margin: 20%;
}
</style>
