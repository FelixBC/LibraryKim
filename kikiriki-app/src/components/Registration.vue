<template>
  <q-page>
    <q-form @submit="submitForm">
      <q-card class="q-ma-md">

        <q-header>
          Cockfight Registration Form
        </q-header>
        <q-card-section>

          <h4> Owner's Information </h4>
          <q-input
              outlined
              v-model="ownername"
              label="ownername"
              required
          ></q-input>

          <q-input
              outlined
              v-model="city"
              label="City"
              required
          ></q-input>
          <q-input
              outlined
              v-model="phone"
              label="Phone"
              required
          ></q-input>
          <h4> Gallo's Information </h4>
          <q-input
              outlined
              v-model="galloName"
              label="Gallo's Name"
              required
          ></q-input>
          <q-input
              outlined
              v-model="wins"
              label="Wins"
              required
          ></q-input>
          <q-input
              outlined
              v-model="loses"
              label="Loses"
              required
          ></q-input>
          <q-input
              outlined
              v-model="breed"
              label="Breed"
              required
          ></q-input>
          <q-input
              outlined
              v-model="age"
              label="Age"
              required
          ></q-input>
          <q-input
              outlined
              v-model="color"
              label="Color"
              required
          ></q-input>
          <q-input
              outlined
              v-model="identificationNumber"
              label="Identification Number"
              required
          ></q-input>
<h4>Medical History</h4>
          <q-input
              outlined
              v-model="vaccinations"
              label="Vaccionations"
              required
          ></q-input>
          <q-input
              outlined
              v-model="deworming"
              label="Deworming"
              required
          ></q-input>
          <q-input
              outlined
              v-model="dateOfLastVeterinaryCheckUp"
              label="Date of last veterinary check up"
              required
          ></q-input>
          <h4>Pedigree information (if applicable)</h4>
          <q-input
              outlined
              v-model="sire"
              label="Sire"
              required
          ></q-input>
          <q-input
              outlined
              v-model="dam"
              label="Dam"
              required
          ></q-input>
          <q-input
              outlined
              v-model="breeder"
              label="Breeder"
              required
          ></q-input>

        </q-card-section>
        <q-card-actions align="right">
          <q-btn
              color="primary"
              label="Submit"
              type="submit"
          ></q-btn>
        </q-card-actions>
      </q-card>
    </q-form>
  </q-page>
</template>

<script>
export default {
  data() {
    return {
      firstName: '',
      lastName: '',
      email: '',
      password: '',
    };
  },
  methods: {
    submitForm() {
      // Handle form submission logic
      console.log('Form submitted!');
    },
  },
};
</script>