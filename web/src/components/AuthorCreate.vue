<script lang="ts" setup>
import {ref} from 'vue'
import {Author} from "./types.ts";
import {useRouter} from "vue-router";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/authors";
const authors = ref<Author[]>([]);
const router = useRouter();

const createAuthor = async () => {
  try {
    const res = await fetch(API_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        author: {
          name: name.value,
        }
      })
    })
    if (!res) {
      throw new Error('Something went wrong')
    }

    const data = await res.json();
    authors.value.push(data);

    router.push('/authors')
  } catch (error) {
    console.error(error)
  }
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
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir un Autor']"/>
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