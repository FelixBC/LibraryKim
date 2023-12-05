<script lang="ts" setup>
import {ref} from 'vue'
import {Gender} from "./types.ts";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/genders";
const genders = ref<Gender[]>([]);

const create = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name.value,
    })
  })
  const data = await res.json()
  genders.value.push(data);
  onReset();
}
const onReset = () => {
  name.value = null;
}

</script>
<template>

  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Crear Genero</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Genero"
                    hint="Femenino"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Genero']"
                />
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="create">Create</q-btn>
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