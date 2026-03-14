<script lang="ts">
    import { onMount } from 'svelte';
    import favicon from '$lib/assets/favicon.svg';
    import Navbar from '$lib/components/layout/Navbar.svelte';
    import { initTheme } from '$lib/utils/theme';
    import '../app.css';

    let { children } = $props();

    onMount(initTheme);
</script>

<svelte:head>
    <link rel="icon" href={favicon} />
</svelte:head>

<Navbar />

{@render children()}