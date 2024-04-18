<script lang="ts" setup>


</script>

<template>
  <div>
    <!-- Bloque 1: Work Info -->
   <div>
      <h2>Work Info</h2>
     <q-select filled v-model="worktype" label="Type" :options="workTypes" />
      <q-input filled v-model="title" label="Title" />
     <q-input filled v-model="authors[0]" label="Author/Artist" />
     <q-btn icon="add" @click="addAuthor" color="primary" class="q-ml-md" />
     <div v-for="(author, index) in authors.slice(1)" :key="index">
       <q-input filled v-model="authors[index + 1]" label="Author/Artist" />
       <q-btn icon="close" @click="removeAuthor(index + 1)" color="negative" />
     </div>
     <q-select filled v-model="year" label="Published" :options="yearOptions" />
      <q-input filled v-model="keyword" label="Key Words" />
      <q-select filled v-model="wordCount" label="Word Count" :options="wordCountOptions" />
      <q-select filled v-model="language" label="Language" :options="languages" />
     <q-select filled v-model="format" label="Formato" :options="formats" />
     <q-select filled v-model="rating" label="Calificación" :options="ratings" />
     <q-checkbox v-model="isSeries" label="Pertenece a alguna serie de libros" />
     <q-select filled v-model="publisher" label="Editorial" :options="publishers" />

    </div>

    <!-- Bloque 2: Work Tags -->
    <div>
      <h2>Work Tags</h2>
      <q-select filled v-model="rating" label="Rating" :options="ratings" />
      <q-select filled v-model="warnings" label="Warnings" :options="warningLevels" />
      <q-input filled v-model="category" label="Categorias" />
      <q-checkbox v-model="selectedCategories" v-for="(category, index) in categories" :key="index" :label="category" />
      <q-input filled v-model="themes" label="Temas" />
      <q-checkbox v-model="themes" v-for="(theme, index) in themeOptions" :key="index" :label="theme" />
      <q-input filled v-model="additionalTags" label="Additional Tags" />
    </div>

    <!-- Bloque 4: Exclusión -->
    <div>
      <h2>Exclusion</h2>
      <q-input filled v-model="category" label="Categorias" />
      <q-checkbox v-model="excludedCategories" v-for="(category, index) in categoryOptions" :key="'excludedCategory' + index" :label="category" />
      <q-input filled v-model="themes" label="Temas" />
      <q-checkbox v-model="excludedThemes" v-for="(theme, index) in themeOptions" :key="'excludedTheme' + index" :label="theme" />
      <q-input filled v-model="excludedKeywords" label="Palabras Clave a Excluir" />
    </div>


    <!-- Bloque 3: Search -->
    <div>
      <h2>Search</h2>
      <q-select filled v-model="sortBy" label="Sort by" :options="sortByOptions" />
      <q-select filled v-model="sortDirection" label="Sort direction" :options="sortDirections" />
      <q-btn color="primary" @click="search">Search</q-btn>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      // Bloque 1: Work Info
      worktype: [''],
      title: '',
      authors: [''],
      year: '',
      keyword: '',
      wordCount: '',
      language: '',
      format: '',
      rating: '',
      isSeries: false,
      publisher: '',

      // Bloque 2: Work Tags
      rating: '',
      warnings: '',
      selectedCategories: [],
      themes: [],
      additionalTags: '',

      // Bloque 3: Search
      sortBy: '',
      sortDirection: '',

      //Bloque 4: Exxlusion
      excludedCategories: [],
      excludedThemes: [],
      excludedKeywords: '',

      // Opciones
      languages: ['English', 'Spanish', 'French', 'German'],
      ratings: ['G', 'PG', 'PG-13', 'R', 'NC-17'],
      categories: ['Ficción', 'No ficción', 'Ciencia ficción', 'Misterio', 'Romance', 'Fantasía', 'Terror', 'Poesía', 'Drama', 'Aventura', 'Historia', 'Biografía', 'Autobiografía', 'Humor', 'Filosofía', 'Psicología', 'Autoayuda', 'Religión', 'Política', 'Economía', 'Arte', 'Cocina', 'Viajes', 'Ciencia', 'Tecnología', 'Educación', 'Deportes', 'Salud', 'Naturaleza', 'Infantil', 'Juvenil'],
      warningLevels: ['None', 'Mild', 'Moderate', 'Explicit'],
      sortByOptions: ['Title', 'Author', 'Date', 'Word Count'],
      sortDirections: ['Ascending', 'Descending'],
      yearOptions: Array.from({length: new Date().getFullYear() - 1899}, (_, i) => i + 1900).reverse(),
      workTypes: ['Novela', 'Cuentos Cortos', 'Revistas', 'Mangas', 'Otros', 'Cómic', 'Guias de Viaje','Álbum ilustrado', 'Libro de actividades', 'Libro de colorear', 'Libro de pasatiempos', 'Álbum de recortes', 'Diario', 'Cuaderno de notas'],
      wordCountOptions: [
        '1 - 5,000', '5,001 - 10,000', '10,001 - 25,000', '25,001 - 50,000',
        '50,001 - 75,000', '75,001 - 100,000', '100,000+'
      ],
      formats: ['Tapa dura', 'Tapa blanda', 'E-book', 'Audiolibro'],

      ratings: ['1 estrella', '2 estrellas', '3 estrellas', '4 estrellas', '5 estrellas'],

      publishers: ['Editorial A', 'Editorial B', 'Editorial C', 'Editorial D'],

      themeOptions: ['Tema 1', 'Tema 2', 'Tema 3', 'Tema 4', 'Tema 5'],

      categoryOptions: ['Ficción', 'No ficción', 'Ciencia ficción', 'Misterio', 'Romance', 'Fantasía', 'Terror', 'Poesía', 'Drama', 'Aventura', 'Historia', 'Biografía', 'Autobiografía', 'Humor', 'Filosofía', 'Psicología', 'Autoayuda', 'Religión', 'Política', 'Economía', 'Arte', 'Cocina', 'Viajes', 'Ciencia', 'Tecnología', 'Educación', 'Deportes', 'Salud', 'Naturaleza', 'Infantil', 'Juvenil'],

      themeOptions: ['Tema 1', 'Tema 2', 'Tema 3', 'Tema 4', 'Tema 5']
    };
  },
  methods: {
    search() {
      console.log('Realizando búsqueda avanzada...');
      console.log('Work Info:');
      console.log('Title:', this.title);
      console.log('Author/Artist:', this.author);
      console.log('Date:', this.year);
      console.log('Word Count:', this.wordCount);
      console.log('Language:', this.language);
      console.log('Work Tags:');
      console.log('Rating:', this.rating);
      console.log('Warnings:', this.warnings);
      console.log('Categories:', this.categories);
      console.log('Additional Tags:', this.additionalTags);
      console.log('Search:');
      console.log('Sort by:', this.sortBy);
      console.log('Sort direction:', this.sortDirection);
    },
    addAuthor() {
      this.authors.push('');
    },
    removeAuthor(index) {
      this.authors.splice(index, 1);
    }
  },
};
</script>
