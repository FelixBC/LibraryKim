<script lang="ts" setup>
import {ref, onMounted} from 'vue'
import {Role, City, Employee, Gender, Province, Sector} from "./types.ts";


const name = ref<string | null>(null)
const identificationNumber = ref<string | null>(null)
const birthDate = ref<string | undefined>()
const phoneNumber = ref<number | undefined>()
const email = ref<string | undefined>()
const province = ref<string | undefined>()
const city = ref<string | undefined>()
const street = ref<string | undefined>()
const salary = ref<string | undefined>()
const selectedValueGenders = ref<string | null>(null)
const selectedValueProvinces = ref<string | null>(null)
const selectedValueCities = ref<string | null>(null)
const selectedValueSectors = ref<string | null>(null)

//converting the data from the api to a type of data that we can use in the app (typescript)

const roles = ref<Role[]>([])
const provinces = ref<Province[]>([])
const sectors = ref<Sector[]>([])
const cities = ref<City[]>([]);
const genders = ref<Gender[]>([]);
const employees = ref<Employee[]>([]);

//This is just to filter between the different options in the select
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
const filteredOptionsProvinces = ref([])
const filterOptionsProvinces = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsProvinces.value = provinces.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsProvinces.value = provinces.value.filter(province => {
      const fullName = `${province.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

const filteredOptionsSectors = ref([])
const filterOptionsSectors = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsSectors.value = sectors.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsSectors.value = sectors.value.filter(sector => {
      const fullName = `${sector.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}
const filteredOptionsCities = ref([])
const filterOptionsCities = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsCities.value = cities.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsCities.value = cities.value.filter(city => {
      const fullName = `${city.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}

const filteredOptionsGenders = ref([])
const filterOptionsGenders = (val, update) => {
  if (val == '') {
    update(() => {
      filteredOptionsGenders.value = genders.value;
    })
  }
  update(() => {
    const needle = val.toLowerCase()
    filteredOptionsGenders.value = genders.value.filter(gender => {
      const fullName = `${gender.name}`.toLowerCase();
      return fullName.includes(needle);
    })
  })
}


//this takes the data from the api

const API_URL = "http://localhost:3000/employees";
const API_URL_PROVINCES = "http://localhost:3000/provinces";
const API_URL_SECTORS = "http://localhost:3000/sectors";
const API_URL_CITIES = "http://localhost:3000/cities";
const API_URL_GENDERS = "http://localhost:3000/employees/general_params";


//load the data from the api

onMounted(async () => {

  //Get the data from the api
  const resGenders = await fetch(API_URL_GENDERS);
  const resProvinces = await fetch(API_URL_PROVINCES);
  const resCities = await fetch(API_URL_CITIES);
  const resSectors = await fetch(API_URL_SECTORS);

//this is going to take the data from the api and push it to the employees array
  const dataGenders = await resGenders.json();
  genders.value = dataGenders as Gender[];
  const dataProvinces = await resProvinces.json();
  provinces.value = dataProvinces as Provinces[];
  const dataCities = await resCities.json();
  cities.value = dataCities as City[];
  const dataSectors = await resSectors.json();
  sectors.value = dataSectors as Sectors[];
});

//this is the data that is going to be sent to the api


//the create function is going to send the data to the api
const createEmployee = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      employee: {
        name: name.value,
        identificationNumber: identificationNumber.value,
        email: email.value,
        phoneNumber: phoneNumber.value,
        birthDate: birthDate.value,
        genders: selectedValueGenders.value.id,
        provinceId: selectedValueProvinces.value.id,
        cityId: selectedValueCities.value.id,
        sectorId: selectedValueSectors.value.id,
        street: street.value,
        salary: salary.value
      }
    })
  })
  //this is going to take the data from the api and push it to the employees array

  const data = await res.json()
  employees.value.push(data);
}


//this is going to reset the form(put it empty)
const onReset = () => {
  name.value = null;
  identificationNumber.value = null;
  birthDate.value = null;
  phoneNumber.value = null;
  email.value = null;
  province.value = null;
  sectors.value = null;
  city.value = null;
  street.value = null;
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
            <h4>Crear empleado</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Nombre"
                    hint="Jose Perez"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir un empleado']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="identificationNumber"
                    label="Cedula "
                    hint="402-0000000-7"
                    mask="###-#######-#"
                    lazy-rules
                    :rules="[val => val && !val.isEmpty && val.length == 13 && (val.includes(402) || val.includes(31)) || 'Debe escribir un identificacion']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="email"
                    type="email"
                    suffix="@gmail.com"
                    label="Gmail"
                    hint="JhonDoe@gmail.com"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty  || 'Debe escribir un email']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    type="tel"
                    mask="###-###-####"
                    v-model="phoneNumber"
                    label="Celular"
                    hint="809-000-0000"
                    lazy-rules
                    :rules="[val => val && !val.isEmpty && val.length == 12 && (val.includes(849) || val.includes(809) || val.includes(829)) || 'Debe escribir un celular valido']"/>
              </q-card-section>
              <q-card-section>
                <q-input filled hint="Fecha De nacimiento" label="2000/01/13" v-model="birthDate" mask="date"
                         :rules="['date']">
                  <template v-slot:append>
                    <q-icon name="event" class="cursor-pointer">
                      <q-popup-proxy cover transition-show="scale" transition-hide="scale">
                        <q-date v-model="birthDate">
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
                      v-model="selectedValueGenders"
                      bg-color="grey-4"
                      label="Genero"
                      option-value="id"
                      option-label="name"
                      :options="genders"
                      :filter="filterOptionsGenders"/>

                </q-card-section>
                <q-card-section>
                  <q-select
                      filled
                      v-model="selectedValueProvinces"
                      bg-color="grey-4"
                      label="Provincia"
                      option-value="id"
                      option-label="name"
                      :options="provinces"
                      :filter="filterOptionsProvinces"/>
                </q-card-section>
                <q-card-section>
                  <q-select
                      filled
                      v-model="selectedValueCities"
                      bg-color="grey-4"
                      label="Ciudad"
                      option-value="id"
                      option-label="name"
                      :options="cities"
                      :filter="filterOptionsCities"/>
                </q-card-section>
                <q-card-section>
                  <q-select
                      filled
                      v-model="selectedValueSectors"
                      bg-color="grey-4"
                      label="Sector"
                      option-value="id"
                      option-label="name"
                      :options="sectors"
                      :filter="filterOptionsSectors"/>
                </q-card-section>
                <q-card-section>
                  <q-input
                      filled
                      v-model="street"
                      label="Calle"
                      hint="Calle 1"
                      lazy-rules
                      :rules="[ val => val && !val.isEmpty || 'Debe escribir una calle']"/>
                </q-card-section>
                <q-card-section>
                  <q-input
                      filled
                      v-model="salary"
                      label="Salario"
                      hint="20000"
                      lazy-rules
                      :rules="[ val => val && !val.isEmpty || 'Debe escribir el salario']"/>
                </q-card-section>
              </div>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createEmployee">Create</q-btn>
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