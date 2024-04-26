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
            </div>
          </div>

        </q-card-section>
      </q-card>
    </q-form>

    <div v-if="showAdvancedFilter" class="advance-filter">
      <h4>Filtros avanzados</h4>
      <q-select
      filled
      label="Categoria"
      v-model="genreFilter"
      :options="categories.map(category => ({ label: category, value: category}))"
      ></q-select>
      <q-input filled label="Ano de Publicacion" v-model="yearFilter"></q-input>
      <q-input filled label="Cantidad de paginas" v-model="pageCountFilter"></q-input>
      <q-btn label="Aplicar Filtros" @click="applyFilters"></q-btn>
    </div>

<!--  :src="book.imageLinks.thumbnail"-->
  <div class="q-pa-md example-row-equal-width">

    <div class="row align-center justify-center">
      <div class="col-3 align-center justify-center" v-for="book in searchResults" :key="book.id">
          <q-card-section v-if="searchResults.length>0" @click="select_book(book)">

            <q-img
                contain
                :src="book.volumeInfo.imageLinks.thumbnail"
                spinner-color="white"
                style="height: 600px; width: 400px"
                @click="showBookDetails"
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
          show_dialog:false,
          loading: false,
          searchQuery: '',
          books: [{id: 1}, {id: 2}],
          searchResults: [],  // Define la variable searchResults y asigna un array vacío inicialmente
          showAdvancedFilter: false,
          genreFilter: '',
          yearFilter: '',
          pageCountFilter: '',
          categories: [],
          selectedBook: {}
        };
      },
      methods: {
        select_book(boock_selected){
        //  console.log('boock selected',boock_selected)
          //esto lo podias poner arriba en el click, pero esta funcion te sirve por si quieres agregar otra logica antes de abrir el dialog
          //this.selectedBook=Object.assign({},boock_selected);
          this.show_dialog=true;
          // for (let prop of boock_selected)
          // {//copilot me dio este codigo mal :v
          //   console.log(`${boock_selected[prop]}`)
          // }
        },
        simpleSearch() {

          this.loading = true;
          fetch('http://localhost:3000/books/search', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({query: this.searchQuery})
          })
              .then(response => response.json())
              .then(data => {
                console.log('aqui si se puede', data)
                this.searchResults = data.items;
                console.log(data.items[0].volumeInfo.imageLinks.thumbnail);
                this.categories = Array.from(data.items.flatMap(book => book.volumeInfo.categories || []));
                this.loading = false;
               this.showAdvancedFilter = true;
              })
              .catch(error => {
                console.error(error);
              });
        },
        applyFilters() {
          const url = 'http://localhost:3000/books/search';
          const filters = {
            query: this.searchQuery,
            categories: this.categories,
            year: this.yearFilter,
            pageCount: this.pageCountFilter
          }
          this.loading = true;
          fetch(url, {
            method: 'post',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(filters)
          })
              .then(response => response.json())
              .then(data => {
                this.searchResults = data.items;
                this.loading = false;
              })
              .catch(error => {
                console.error(error);
                this.loading = false;
              });
        }
      }
    };
  </script>
