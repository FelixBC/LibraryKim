<script lang="ts" setup>

/*export default {
  methods: {
    advancedSearch() {

      this.$router.push('/advanced-search');
    }
  }
}*/

</script>
<template>
  <q-page class="flex-md-center" padding>
    <q-form>
      <q-card class="full-width" style="max-width: 450px;">
        <q-card-section style="font-size: 1.3em;" class="text-center">
          <q-card-section>
            <h4>Búsqueda de Libros</h4>
          </q-card-section>

          <div class="form-columns">
            <div class="form-column">
              <q-card-section>
                <q-input
                    filled
                    v-model="searchQuery"
                    label="Buscar libro"
                    hint="Título, autor, etc."
                    lazy-rules
                    :rules="[ val => val && !val.isEmpty || 'Debe escribir algo para buscar']"/>
              </q-card-section>
            </div>
            <div class="divButtons">
              <q-btn color="primary" @click="simpleSearch">Buscar</q-btn>
              <q-btn label="Búsqueda Avanzada" type="button" color="primary" flat class="q-ml-sm" @click="advancedSearch"/>
            </div>
          </div>




        </q-card-section>
      </q-card>
    </q-form>
  </q-page>
</template>

<style scoped>


</style>