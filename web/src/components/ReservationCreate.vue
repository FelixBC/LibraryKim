<script lang="ts" setup>
import { ref } from 'vue';
import { Reservation } from "./types.ts";

const eventID = ref<number | null>(null);
const clientID = ref<number | null>(null);
const status = ref<string | null>(null);

const API_URL = "http://localhost:3000/reservations";
const reservations = ref<Reservation[]>([]);

const createReservation = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      eventID: eventID.value,
      clientID: clientID.value,
      status: status.value,
    })
  });

  const data = await res.json();
  reservations.value.push(data);
  resetForm();
};

const resetForm = () => {
  eventID.value = null;
  clientID.value = null;
  status.value = null;
};

</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Crear Reserva</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="eventID"
                    label="ID del Evento"
                    type="number"
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="clientID"
                    label="ID del Cliente"
                    type="number"
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="status"
                    label="Estado"
                    hint="Estado de la Reserva"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir un estado']"
                />
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createReservation">Crear Reserva</q-btn>
              <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
            </div>
          </div>

        </q-card-section>
      </q-card>
    </q-form>
  </q-page>
</template>

<style scoped>
</style>
