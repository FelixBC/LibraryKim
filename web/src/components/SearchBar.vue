<!--<script lang="ts">
import { ref } from 'vue';

export default {
  setup() {
    const searchQuery = ref('');

    const simpleSearch = () => {
      fetch('/search', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ query: searchQuery.value })
      })
          .then(response => response.json())
          .then(data => {
            // Manejar la respuesta del servidor
          })
          .catch(error => {
            console.error(error);
          });
    };

    return {
      searchQuery,
      simpleSearch
    };
  }
}
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


</style> -->

<template>
  <q-page class="flex-md-center" padding>
    <q-form @submit="simpleSearch">
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
              <q-btn color="primary" type="submit" v-if="!loading">Buscar</q-btn>
                <q-spinner v-if="loading"
                          color="primary"

                                  size="3em"

                                />
              <q-btn label="Búsqueda Avanzada" type="button" color="primary" flat class="q-ml-sm" @click="advancedSearch"/>
            </div>
          </div>

        </q-card-section>
      </q-card>
    </q-form>

<!--  :src="book.imageLinks.thumbnail"-->
  <div class="q-pa-md example-row-equal-width">

    <div class="row align-center justify-center">
      <div class="col-3 align-center justify-center" v-for="book in searchResults" :key="book.id">
          <q-card-section v-if="searchResults.length>0">
            <q-img
                contain
                :src="book.volumeInfo.imageLinks.thumbnail"
                spinner-color="white"
                style="height: 80%; width: 80%"
            />
            <q-card-actions >
              <span style="font-size:20px; text-align:center; display:inline-block; width:100%">{{book.volumeInfo.title}}</span>
<!--              <span style="font-size:20px; text-align:center; display:inline-block; width:100%">{{book.imageLinks.thumbnail}}</span>-->
            </q-card-actions>
          </q-card-section>
      </div>
    </div>
  </div>
  </q-page>

<!--    <q-card class="full-width" style="max-width: 450px;" v-if="searchResults && searchResults.length">-->
<!--      <q-card-section>-->
<!--        <h4>Resultados de la búsqueda</h4>-->
<!--        <ul>-->
<!--          <li v-for="book in searchResults" :key="book.id">-->
<!--            {{ book.volumeInfo.title }}-->
<!--          </li>-->
<!--        </ul>-->
<!--      </q-card-section>-->
<!--    </q-card>-->
<!--  <span v-if="searchResults.length>0">{{searchResults[0]}}</span>-->
  </template>

  <script>
    export default {
      data() {
        return {
          loading:false,
          searchQuery: '',
          books:[{id:1},{id:2}],
          searchResults: [] // Define la variable searchResults y asigna un array vacío inicialmente
        };
      },
      methods: {
        simpleSearch() {
          // if(this.searchQuery ==''){
          //   console.error('Indique una busqueda');
          // }


          this.loading=true;
          fetch('http://localhost:3000/books/search', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ query: this.searchQuery })
          })
              .then(response => response.json())
              .then(data => {
                console.log('aqui si se puede',data)
                this.searchResults = data.items;
                console.log(data.items[0].volumeInfo.imageLinks.thumbnail)
                this.loading=false;
              })
              .catch(error => {
                console.error(error);
              });
        },
        advancedSearch() {
          // Implementa la lógica para la búsqueda avanzada si es necesario
        }
      }
    };
  </script>
