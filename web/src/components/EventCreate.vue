<script lang="ts" setup>
import {ref} from 'vue';
import {Event} from "./types.ts";
import {useRouter} from "vue-router";

const name = ref<string | null>(null);
const eventDate = ref<string | null>(null);
const description = ref<string | null>(null);
const imageUrl = ref<string | null>(null);
const capacity = ref<integer | null>(null);


const API_URL = "http://localhost:3000/events";
const events = ref<Event[]>([]);
const router = useRouter();

const create = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      event: {
        name: name.value,
        eventDate: eventDate.value,
        description: description.value,
        imageUrl: imageUrl.value,
        capacity: capacity.value,
      }
    })
  });

  const data = await res.json();
  events.value.push(data);
  router.push('/events');
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
                    v-model="eventDate"
                    label="Fecha del Evento"
                    type="date"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe seleccionar una fecha']"/>
                <q-input
                    filled
                    v-model="description"
                    label="Descripcion"
                    hint="Descripcion del Evento"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir una descripcion']"/>
                <q-input
                    filled
                    v-model="imageUrl"
                    label="Url de Imagen"
                    hint="URL de la imagen (completa)"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir una URL']"
                />
                <q-input
                    filled
                    v-model="capacity"
                    label="Capacidad"
                    hint="Capacidad de reservas por dia del evento"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe indicar la capacidad']" />
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