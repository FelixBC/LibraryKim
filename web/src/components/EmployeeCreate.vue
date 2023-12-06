<script lang="ts" setup>
import {ref} from 'vue'
import {Employee} from "./types.ts";

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
const API_URL_PHONENUMBER = "";


const genders = ref<Employee[]>([]);
const roles = ref<Roles[]>([]);
const adresses = ref<Adresses[]>([]);
const phonenumbers = ref<Phonenumbers[]>([]);
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
      birth_date: birth_date.value,
      phoneNumber: phoneNumber.value,
      email: email.value,
      country: country.value,
      province: province.value,
      sector: sector.value,
      city: city.value,
    })
  })
  const data = await res.json()
  employees.value.push(data);
  onReset();
}
const onReset = () => {
  name.value = null;
  roles.value = null;
  genders.value = null;
  identificationNumber.value = null;
  birth_date.value = null;
  phoneNumber.value = null;
  email.value = null;
  country.value = null;
  province.value = null;
  sector.value = null;
  city.value = null;
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
            <h4>Crear Employee</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Employee*"
                    hint="Jhon Doe"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un empleado']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model=""
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