<script lang="ts" setup>
import { ref } from 'vue';
import { ReservationSpace } from "./types.ts";

const name = ref<string | null>(null);
const capacity = ref<number | null>(null);
const availability = ref<string | null>(null);

const API_URL = "http://localhost:3000/reservation_spaces";
const reservationSpaces = ref<ReservationSpace[]>([]);

const create = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name.value,
      capacity: capacity.value,
      availability: availability.value,
    })
  });

  const data = await res.json();
  reservationSpaces.value.push(data);
  onReset();
};

const onReset = () => {
  name.value = null;
  capacity.value = null;
  availability.value = null;
};

</script>

<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Crear Espacio de Reserva</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Nombre"
                    hint="Nombre del Espacio"
                    lazy-rules
                    :rules="[val => val && val.trim() !== '' || 'Debe escribir un nombre']"
                />
                <q-input
                    filled
                    v-model="capacity"
                    label="Capacidad"
                    type="number"
                    lazy-rules
                    :rules="[val => !isNaN(val) || 'Debe ser un número']"
                />
                <q-input
                    filled
                    v-model="availability"
                    label="Disponibilidad"
                    hint="Disponible o No disponible"
                    lazy-rules
                    :rules="[val => val && (val.toLowerCase() === 'disponible' || val.toLowerCase() === 'no disponible') || 'Debe ser Disponible o No disponible']"
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
>