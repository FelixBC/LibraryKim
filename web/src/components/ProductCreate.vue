<script lang="ts" setup>
import {ref} from 'vue'
import {Author} from "./types.ts";

const name = ref<string | null>(null)
const API_URL = "http://localhost:3000/authors";
const authors = ref<Author[]>([]);

const createAuthor = async () => {
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
  authors.value.push(data);
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
            <h4>Crear Producto</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">

              <div class="col">
                <q-card-section>
                  <q-select
                      filled
                      v-model="selectedValueRoles"
                      bg-color="grey-4"
                      label="Tipo de producto"
                      option-value="id"
                      option-label="Tipo de producto"
                      :options="roles"
                      :filter="filterOptionsRoles"
                  />
                </q-card-section>
                <q-card-section>

                  <q-select
                      filled
                      v-model="selectedValueGenders"
                      bg-color="grey-4"
                      label="Suplidor"
                      option-value="id"
                      option-label="name"
                      :options="genders"
                      :filter="filterOptionsGenders"
                  />

                </q-card-section>
              </div>
              <q-card-section>
                <q-input
                    filled
                    v-model="name"
                    hint="10"
                    label="Cantidad"
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir un empleado']"
                />
              </q-card-section>
              <q-card-section>
                <q-input
                    filled
                    v-model="identificationNumber"
                    label="Precio"
                    prefix="$"
                    hint="20.00"
                    mask="#######.##"
                    lazy-rules
                    :rules="[val => val && !val.isEmpty && val.length == 13 && (val.includes(402) || val.includes(31)) || 'Debe escribir un identificacion']"
                />
              </q-card-section>
              <q-card-section>
                <q-input filled hint="Fecha De Registro" label="2000/01/13" v-model="date" mask="date"
                         :rules="['date']">
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
            </div>
          </div>
          <div class="divButtons">
            <q-btn color="primary" @click="createAuthor">Create</q-btn>
            <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
          </div>
        </q-card-section>
      </q-card>
    </q-form>
  </q-page>
</template>
<style scoped>


</style>