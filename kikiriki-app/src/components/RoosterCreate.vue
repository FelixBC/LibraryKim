<script lang="ts" setup>
import {useQuasar} from 'quasar'
import {onMounted, ref, computed} from 'vue'
import {Owner, Rooster} from "./types.ts";

const $q = useQuasar()

const name = ref<string | null>(null)
const breed = ref<string | null>(null)
const color = ref<string | null>(null)
const strength = ref<number | null>(null)
const resistance = ref<number | null>(null)
const agility = ref<number | null>(null)
const defence  = ref<number | null>(null)
const wins = ref<number | null>(null)
const loses = ref<number | null>(null)
const accept = ref(false)
const owners = ref<Owner[]>([])
const ownerId = ref(0)
const isEditing = ref(false)
const API_URL = "http://localhost:3000/roosters";
const model = ref('');
const roosterOwner_id = ref(0)

    const filteredOptions = computed(() => {
  return owners.value.filter((owner) => {
    const fullName = `${owner.name} ${owner.lastName}`;
    return fullName.toLowerCase().includes(model.value.toLowerCase());
  });
});

const filterFn = (query, option) => {
  const fullName = `${option.name} ${option.lastName}`;
  return fullName.toLowerCase().includes(query.toLowerCase());
};

const filterFnBreed = (query, option) => {
  const fullName = `${option.name} ${option.lastName}`;
  return fullName.toLowerCase().includes(query.toLowerCase());
};

onMounted(async () => {
  const res = await fetch(API_URL);
  const data = await res.json();
  owners.value = data as Owner[];
});

const createRooster = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: name.value,
      breed: breed.value,
      color: color.value,
      strength: strength.value,
      resistance: resistance.value,
      agility: agility.value,
      defence: defence.value,
      roosterOwner_id: roosterOwner_id.value,
      wins: wins.value,
      loses: loses.value,
    })
  })

  const data = await res.json()
  roosters.value.push(data)
  onReset()
}




const onReset = () => {
  name.value = null
  breed.value = null
  color.value = null
  strength.value = null
  resistance.value = null
  agility.value = null
  defence.value = null
  wins.value = null
  loses.value = null
  accept.value = false

}
</script>

<template>
  <q-card>
    <div class="header_form">
      <h4>Crear Gallo</h4>
      <q-separator dark/>
    </div>
    <div class="divMainContent">

      <q-form>
        <div class="form-columns">
          <div class="form-column">
            <q-input
                filled
                v-model="name"
                label="Nombre *"
                hint="Kikito"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Debe escribir un nombre']"
            />
            <q-select
                filled
                v-model="model"
                use-input
                input-debounce="0"
                label="Seleccionar raza"
                :options="filteredOptionsBreed"
                :filter-method="filterfnBreed"
                style="width: 250px"
                behavior="menu"
            >
            </q-select>
            <q-input
                filled
                v-model="color"
                label="Color del plumaje *"
                hint="Blanco"
                lazy-rules
                :rules="[ val => val && val.length > 0 || 'Debe escribir una ciudad']"
            />
            <q-input
                filled
                type="number"
                v-model="wins"
                label="Ganadas *"
                lazy-rules
                :rules="[
          val => val !== null && val !== '' || 'Digite su edad',
          val => val > 0 && val < 100 || 'Por favor digite una edad real'
        ]"
            />
            <q-input
                filled
                type="number"
                v-model="loses"
                label="Perdidas *"
                lazy-rules
                :rules="[
          val => val !== null && val !== '' || 'Digite su edad',
          val => val > 0 && val < 100 || 'Por favor digite una edad real'
        ]"
            />

          </div>
            <div class="column">
            <q-input
                filled
                type="number"
                v-model="strength"
                label="Fuerza *"
                lazy-rules
                :rules="[
          val => val !== null && val !== '' || 'digite su cedula',
          val => val > 0 && val < 99999999999 || 'Por favor digite su cedula'
        ]"
            />


            <q-input
                filled
                type="number"
                v-model="resistance"
                label="Resistencia *"
                lazy-rules
                :rules="[
          val => val !== null && val !== '' || 'Digite su numero de telefono',
          val => val > 0 && val < 9999999999 || 'Por favor digite un telefono real'
        ]"
            />
            <q-input
                filled
                type="number"
                v-model="agility"
                label="Agilidad *"
                lazy-rules
                :rules="[
          val => val !== null && val !== '' || 'Por favor digite el numero de ganadas',
          val => val > 0 && val < 100 || 'Por favor digite un numero de ganadas real '
        ]"
            />
            <q-input
                filled
                type="number"
                v-model="defence"
                label="Defensa *"
                lazy-rules
                :rules="[
          val => val !== null && val !== '' || 'Por favor digite numero de perdidas',
          val => val > 0 && val < 100 || 'Por favor digite un numero de perdidas'
        ]"
            />
              <q-select
                  filled
                  v-model="model"
                  use-input
                  input-debounce="0"
                  label="Filter by Name and Last Name"
                  :options="filteredOptions"
                  :filter-method="filterFn"
                  style="width: 250px"
                  behavior="menu"
              >
              </q-select>
            </div>
        </div>
        <div class="divButtons">
          <q-btn color="primary" @click="createRooster">Create</q-btn>
          <q-btn label="Reset" type="reset" color="primary" flat class="q-ml-sm"/>
        </div>

      </q-form>



    </div>
  </q-card>
</template>

<style scoped>

.divMainContent {
  margin-left: 25%;
  padding-right: 25%;
}

.divButtons {
  margin-left: 34%;
  padding: 5%;
}

.form-columns {
  position: relative;
  align-content: center;
  display: flex;
  padding: 8%;
  margin-left: 15%;
}

.form-column {
  flex: 1;
  margin-right: 10px;
}

.header_form {
  padding-top: 5%;
  text-align: center;
}
</style>