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
              <q-btn color="primary" type="submit">Buscar</q-btn>
              <q-btn label="Búsqueda Avanzada" type="button" color="primary" flat class="q-ml-sm" @click="advancedSearch"/>
            </div>
          </div>

        </q-card-section>
      </q-card>
    </q-form>
  </q-page>


    <q-card class="full-width" style="max-width: 450px;" v-if="searchResults && searchResults.length">
      <q-card-section>
        <h4>Resultados de la búsqueda</h4>
        <ul>
          <li v-for="book in searchResults" :key="book.id">
            {{ book.title }}
          </li>
        </ul>
      </q-card-section>
    </q-card>
  </template>

  <script>
    export default {
      data() {
        return {
          searchQuery: '',
          searchResults: [] // Define la variable searchResults y asigna un array vacío inicialmente
        };
      },
      methods: {
        simpleSearch() {
          fetch('/books/search', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({ query: this.searchQuery })
          })
              .then(response => response.json())
              .then(data => {
                // Maneja la respuesta del servidor y asigna los resultados a searchResults
                console.log(this.searchResults = data.items); // Suponiendo que 'data' contiene una lista de resultados de búsqueda
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

<!--

<template>
  <div>
    <h1>Search for books</h1>
    <form @submit.prevent="submitSearch">
      <label>
        <input type="text" v-model="query" placeholder="Search...">
      </label>
      <button type="submit">Search</button>
    </form>
    <h2 v-if="results.length">Results</h2>
    <ul v-if="results.length">
      <li v-for="result in results" :key="result.id">{{ result.title }}</li>
    </ul>
    <p v-else>No results found</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      query: '',
      results: []
    };
  },
  methods: {
    submitSearch() {
      fetch(`/books/search?query=${encodeURIComponent(this.query)}`)
          .then(response => {
            // Verificar si la respuesta es exitosa
            if (!response.ok) {
              throw new Error('Network response was not ok');
            }
            // Convertir la respuesta a JSON
            return response.json();
          })
          .then(data => {
            // Imprimir la respuesta para verificar el formato
            console.log('Respuesta del servidor:', data);
            // Actualizar los resultados con los datos recibidos del servidor
            this.results = data;
          })
          .catch(error => {
            console.error('Error al realizar la solicitud:', error);
          });
    }


  }
};
</script>

<style scoped>
/* Estilos específicos del componente */
</style>
-->