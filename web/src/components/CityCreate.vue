<script lang="ts" setup>
import {ref} from 'vue'
import {Province} from "./types.ts";
import {useRouter} from "vue-router";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/cities";
const PROVINCES_API_URL = "http://localhost:3000/provinces";
const provinces = ref<Province[]>([]);
const selectedValueProvinces = ref<string | null>(null)
const router = useRouter();

const fetchProvinces = async () => {
  try {
    const response = await fetch(PROVINCES_API_URL);
    if (!response.ok) {
      throw new Error('Failed to fetch provinces');
    }
    provinces.value = await response.json();
    console.log(provinces.value);
  } catch (error) {
    console.error('Error fetching provinces:', error);
  }
};
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

const createCity = async () => {
  try {
    const res = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        city: {
          name: name.value,
          province_id: selectedValueProvinces.value.id
        }
      })
    })
    if (!res.ok) {
      throw new Error('Error creating city');
    }
    await router.push('/cities');
  } catch (error) {
    console.error('Failed to create city:', error);
    // Handle the error appropriately
  }
}
const onReset = () => {
  name.value = null;
}

fetchProvinces();

</script>
<template>

  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Crear Ciudad</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-select
                    filled
                    v-model="selectedValueProvinces"
                    bg-color="grey-4"
                    label="Provincia"
                    option-value="id"
                    option-label="name"
                    :options="provinces"
                    :filter="filterOptionsProvinces"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe selectionar una provincia']"/>
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="City *"
                    hint="Santiago de los caballeros"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir un ciudad']"/>
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createCity">Create</q-btn>
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