<script lang="ts" setup>
import {ref} from 'vue';
import {useRouter} from 'vue-router';
import {Province} from "./types.ts";

const name = ref<string | null>(null);
const API_URL = "http://localhost:3000/provinces";
const province = ref<Province[]>([]);
const router = useRouter();

const createProvince = async () => {
  try {
    const res = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        name: name.value,
      })
    });
    if (!res.ok) {
      throw new Error('Error creating province');
    }
    await router.push('/provinces');
  } catch (error) {
    console.error('Failed to create province:', error);
    // Handle the error appropriately
  }
};

const onReset = () => {
  name.value = null;
};
</script>
<template>

  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section
            style="font-size: 1.3em;"
            class="text-center">
          <q-card-section>
            <h4>Crear Provincia</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    label="Ciudad *"
                    hint="Santiago"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir una ciudad']"/>
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="createProvince">Crear</q-btn>
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