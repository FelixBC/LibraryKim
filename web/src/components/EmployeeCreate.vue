<script lang="ts" setup>
import {ref, onMounted} from 'vue'
import {City, Employee, Gender} from "./types.ts";
import {Role} from "./types.ts";


const name = ref<string | null>(null)
const identificationNumber = ref<string | null>(null)
const birth_date = ref<string | undefined>()
const phoneNumber = ref<number | undefined>()
const email = ref<string | undefined>()
const country = ref<string | undefined>()
const province = ref<string | undefined>()
const sector = ref<string | undefined>()
const city = ref<string | undefined>()
const date = ref<string | undefined>()
const selectedValueRoles = ref<string | null>(null)
const filteredOptionsRoles = ref([])
const filterOptionsRoles = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsRoles.value = roles.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsRoles.value = roles.value.filter(role => {
      const fullName = `${role.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

//this takes the data from the api

const API_URL = "http://localhost:3000/employee";
const API_URL_ROLES = "http://localhost:3000/roles";

//load the data from the api
onMounted(async () => {
  const res = await fetch(API_URL_ROLES);
  const data = await res.json();
  roles.value = data as Roles[];
});

//this is the data that is going to be sent to the api

const roles = ref<Role[]>([])
const genders = ref<Gender[]>([]);
const cities = ref<City[]>([]);
const phonenumbers = ref<PhoneNumber[]>([]);
const employees = ref<Employee[]>([]);
const selection = ref<string | null>(null);

//the create function is going to send the data to the api
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
  //this is going to take the data from the api and push it to the employees array
  const data = await res.json()
  employees.value.push(data);
  onReset();
}

//this is going to reset the form(put it empty)
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
                    v-model="identificationNumber"
                    label="Cedula *"
                    hint="402-0000000-7"
                    lazy-rules
                    :rules="[ val => val && val.isEmpty || 'Debe escribir un Autor']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="email"
                    label="Gmail *"
                    hint="Jhon Doe@gmail.com"
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
                  <q-input filled v-model="date" mask="date" :rules="['date']">
                    <template v-slot:append>
                      <q-icon name="event" class="cursor-pointer">
                        <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                          <q-date v-model="date">
                            <div class="row items-center justify-end">
                              <q-btn v-close-popup label="Close" color="primary" flat/>
                            </div>
                          </q-date>
                        </q-popup-proxy>
                      </q-icon>
                    </template>
                  </q-input>


              </q-card-section>
              <div class="col">
                <q-card-section>
                  <q-select
                      filled
                      v-model="selectedValueRoles"
                      bg-color="grey-4"
                      label="Roles"
                      option-value="id"
                      option-label="name"
                      :options="filteredOptionsRoles"
                      :filter="filterOptionsRoles"
                  />
                </q-card-section>
                <q-card-section>
                  <q-select
                      filled
                      v-model="selection"
                      bg-color="red-2"
                      label="Ciudad"
                      :options="cities"
                  />

                </q-card-section>
                <q-card-section>
                  <q-select
                      filled
                      v-model="selection"
                      bg-color="red-2"
                      label="Ciudad"
                      :options="cities"
                  />

                </q-card-section>
                <q-card-section>
                  <q-select
                      filled
                      v-model="selection"
                      bg-color="red-2"
                      label="Ciudad"
                      :options="cities"
                  />

                </q-card-section>

              </div>
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
.form-columns {
  display: flex;
  flex-direction: column;
}

</style>