<script lang="ts" setup>
import {ref} from 'vue'
import {Author} from "./types.ts";

const roles = ref<Roles[]>([])
const name = ref<string | null>(null)
const genders = ref<genders[]>([])
const identificationNumber = ref<string | null>(null)
const birth_date = ref<string | undefined>()
const phoneNumber = ref<number | undefined>()
const email = ref<string | undefined>()
const country = ref<string | undefined>()
const province = ref<string | undefined>()
const sector = ref<string | undefined>()
const city = ref<string | undefined>()

const API_URL = "http://localhost:3000/employee";
const API_URL_GENDER = "";
const API_URL_ROLES = "";
const API_URL_Address = "";
const API_URL


const employees = ref<Employee[]>([]);

const createAuthor = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      roles: roles.value,
      name: name.value,
      genders: genders.value,
      identificationNumber: identificationNumber.value,
      birth_date: birth_date.value
    })
  })
  const data = await res.json()
  employees.value.push(data);
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
            <h4>Crear Autor</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Author *"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Author *"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Author *"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Author *"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Author *"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Author *"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createAuthor">Create</q-btn>
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