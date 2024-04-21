<script setup lang="ts">
</script>
<template>
<form id="searchForm">
<input type="text" id="searchQuery" placeholder="Enter search query">
<button type="submit">Search</button>
</form>

<div id="searchResults"></div>
</template>

<script>

document.getElementById('searchForm').addEventListener('submit', function(event) {
event.preventDefault();
var query = document.getElementById('searchQuery').value;

// Make AJAX request to backend
fetch('/books/search?query=' + encodeURIComponent(query))
.then(response => response.json())
.then(data => {
// Render search results
displaySearchResults(data);
})
.catch(error => {
console.error('Error:', error);
});
});

function displaySearchResults(books) {
var resultsContainer = document.getElementById('searchResults');
resultsContainer.innerHTML = ''; // Clear previous results

if (books.length === 0) {
resultsContainer.innerHTML = 'No results found';
} else {
var ul = document.createElement('ul');
books.forEach(function(book) {
var li = document.createElement('li');
li.textContent = book.title; // Adjust according to your book data structure
ul.appendChild(li);
});
resultsContainer.appendChild(ul);
}
}
</script>