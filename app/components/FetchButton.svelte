<!-- FetchButton.svelte -->

<script>
  import { onMount } from 'svelte';

  // Function to fetch data from PokeAPI for URL
  function fetchPokemonUrl() {
    fetch('https://pokeapi.co/api/v2/pokemon?limit=1')
      .then(response => response.json())
      .then(data => {
        // Extract the Pokemon URL from the fetched data
        const pokemonUrl = data.results[0].url;

        // Update the URL form field on your POKEMON NEW page
        const pokemonUrlInput = document.getElementById('pokemon_url');
        if (pokemonUrlInput) {
          pokemonUrlInput.value = pokemonUrl;
        }
      })
      .catch(error => {
        console.error('Error fetching Pokemon URL:', error);
      });
  }
</script>

<button on:click={fetchPokemonUrl}>Fetch Pokemon URL (Svelte)</button>
