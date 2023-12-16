<script lang="ts" setup>
import { ref } from 'vue';
import { Event } from "./types.ts";

const name = ref<string | null>(null);
const dateEvent = ref<string | null>(null);
const timeEvent = ref<string | null>(null);
const currentDate = ref<string | null>(null);
const description = ref<string | null>(null);


const API_URL = "http://localhost:3000/events";
const events = ref<Event[]>([]);

const create = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name.value,
      dateEvent: dateEvent.value,
      timeEvent: timeEvent.value,
      currentDate: now,
      description: Description.value,
    })
  });

  const data = await res.json();
  events.value.push(data);
  onReset();
};

const onReset = () => {
  name.value = null;
  dateEvent.value = null;
  timeEvent.value = null;
  description.value = null;
};

</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Crear Evento</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Nombre"
                    hint="Nombre del Evento"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir un nombre']"
                />
                <q-input
                    filled
                    v-model="dateEvent"
                    label="Fecha del Evento"
                    type="date"
                    lazy-rules
                    :rules="[val => val || 'Debe seleccionar una fecha']"
                />
                <q-input
                    filled
                    v-model="timeEvent"
                    label="Hora del Evento"
                    type="time"
                    lazy-rules
                    :rules="[val => val || 'Debe seleccionar una hora']"
                />
                <q-input
                    filled
                    v-model="description"
                    label="Descripcion"
                    hint="Descripcion del Evento"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir una descripcion']"
                />
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="create">Crear</q-btn>
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