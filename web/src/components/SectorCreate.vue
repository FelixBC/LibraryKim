<script lang="ts" setup>
import {ref} from 'vue'
import {City} from "./types.ts";
import {useRouter} from "vue-router";

const name = ref<string | null>(null)
const CITIES_API_URL = "http://localhost:3000/cities";
const API_URL = "http://localhost:3000/sectors";
const cities = ref<City[]>([]);
const selectedValueCities = ref<string | null>(null)
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
const router = useRouter();


const createCity = async () => {
  try {
    const res = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        sector: {
          name: name.value,
          city_id: selectedValueCities.value.id
        }
      })
    })
    if(res.ok){
      await router.push('/sectors');
    }
    else{
      throw new Error('Error creating sector');
    }
  } catch (error) {
    console.log('Failed to create sector:', error);
  }
}

const fetchCities = async () => {
  try {
    const response = await fetch(CITIES_API_URL);
    if (!response.ok) {
      throw new Error('Failed to fetch cities');
    }
    cities.value = await response.json();
    console.log(cities.value);
  } catch (error) {
    console.error('Error fetching cities:', error);
  }
};

fetchCities();

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
            <h4>Crear sector</h4>
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
            <q-input
                filled
                v-model="name"
                label="Sector *"
                hint="Puan, Caballito, etc."
                lazy-rules
                :rules="[ val => val && !val.isEmpty || 'Debe escribir un sector']"/>
          </q-card-section>
          <div class="divButtons">
            <q-btn color="primary" @click="createCity">Create</q-btn>
            <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
          </div>
        </q-card-section>
      </q-card>
    </q-form>
  </q-page>
</template>
<style scoped>


</style>