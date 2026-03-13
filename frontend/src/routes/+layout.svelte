<script lang="ts">
  import { onMount } from 'svelte';
  
  import favicon from '$lib/assets/favicon.svg';
  import Navbar from '$lib/components/Navbar.svelte';

  import '../app.css';

  let { children } = $props();

  onMount(() => {
    const savedTheme = localStorage.getItem('theme');

    if (savedTheme === 'light' || savedTheme === 'dark') {
      document.documentElement.classList.toggle('dark', savedTheme === 'dark');
    } else {
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      const nextTheme = prefersDark ? 'dark' : 'light';

      document.documentElement.classList.toggle('dark', nextTheme === 'dark');
      
      localStorage.setItem('theme', nextTheme);
    }
  });
</script>

<svelte:head>
  <link rel="icon" href={favicon} />
  <script lang="ts">
  const theme = localStorage.getItem("theme");
    if (theme === "dark") {
      document.documentElement.classList.add("dark");
    }
  </script>
</svelte:head>
<Navbar />
{@render children()}
