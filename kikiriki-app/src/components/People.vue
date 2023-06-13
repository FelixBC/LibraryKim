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
          <q-btn color= "primary" v-if="isEditing" @click="updateForm">Update</q-btn>
          <q-btn color="primary" v-if="isEditing" @click="cancelEdit">Cancel</q-btn>
          <q-btn color="primary" v-else @click="createPerson">Create</q-btn>
          
        </q-card-actions>
      </q-card>
  </q-page>
</template>
<script lang="ts" setup>
import { ref, onMounted } from 'vue';
// Declare and initialize your data using the `ref()` function
const firstName = ref('');
const lastName = ref('');
const phoneNumber = ref('');
const persons = ref([])
const person_id = ref(0)
const isEditing = ref(false)
const API_URL = "http://localhost:3000/people";


const createPerson = async() => {
  const res = await fetch(API_URL,{
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
  person_id.value = 0;
}
const updateForm = async () => {
 return true;
}
const cancelEdit = () => {
  return true;
}

</script>


