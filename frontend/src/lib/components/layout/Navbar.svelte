<script lang="ts">
  import { onMount } from 'svelte';
  import Search from 'lucide-svelte/icons/search';
  import { AnimatedThemeToggler } from '$lib/components/magic/animated-theme-toggler';
  import {
    attachNavbarPaletteShortcuts,
    closeNavbarPalette,
    getFilteredNavbarHistory,
    handleNavbarPaletteInputKeydown,
    navbarHistoryItems,
    navbarLinks,
    openNavbarPalette,
    resetNavbarHistoryPreview,
    selectNavbarHistoryItem,
    submitNavbarPaletteSearch
  } from '$lib/features/search/navbar';
  import { timeAgo } from '$lib/utils/time';

  let isPaletteOpen = $state(false);
  let paletteId = $state('');
  let paletteInput: HTMLInputElement | null = $state(null);
  let activeHistoryIndex = $state(-1);
  let previewFilterQuery = $state<string | null>(null);

  const paletteBindings = {
    getInput: () => paletteInput,
    getIsOpen: () => isPaletteOpen,
    setIsOpen: (value: boolean) => {
      isPaletteOpen = value;
    },
    getValue: () => paletteId,
    setValue: (value: string) => {
      paletteId = value;
    },
    getActiveHistoryIndex: () => activeHistoryIndex,
    setActiveHistoryIndex: (value: number) => {
      activeHistoryIndex = value;
    },
    getPreviewFilterQuery: () => previewFilterQuery,
    setPreviewFilterQuery: (value: string | null) => {
      previewFilterQuery = value;
    },
    getHistoryItems: () => navbarHistoryItems
  };

  const filteredHistory = $derived.by(() => {
    return getFilteredNavbarHistory(navbarHistoryItems, paletteId, previewFilterQuery);
  });

  onMount(() => {
    return attachNavbarPaletteShortcuts(paletteBindings);
  });
</script>

<nav class="fixed top-0 left-0 z-30 w-full border-b border-border bg-background/95 backdrop-blur-md">
  <div class="mx-auto flex h-20 w-full items-center justify-between px-6">
    <div class="flex items-center gap-12">
      <a href="/" class="flex items-center gap-2 text-[18px] font-semibold text-foreground">
        <span
          aria-hidden="true"
          class="inline-flex h-7 w-7 items-center justify-center rounded-md border border-black/20 bg-black/90 dark:border-white/20 dark:bg-white/10"
        >
          <svg viewBox="0 0 24 24" class="h-4 w-4 fill-white" aria-hidden="true">
            <path d="M12 2 3 7v10l9 5 9-5V7l-9-5Zm0 2.2 6.8 3.8L12 11.8 5.2 8 12 4.2Zm-7 5.5 6 3.4v6.2l-6-3.3V9.7Zm8 9.6v-6.2l6-3.4V16l-6 3.3Z" />
          </svg>
        </span>
        <span>Veritas</span>
      </a>

      <div class="hidden items-center gap-10 md:flex">
        {#each navbarLinks as link}
          <a
            href={link.href}
            class="text-[16px] text-foreground/70 transition hover:text-foreground"
          >
            {link.label}
          </a>
        {/each}
      </div>
    </div>

    <div class="flex items-center gap-3">
      <button
        class="hidden h-10 cursor-pointer items-center gap-3 rounded-xl border border-border bg-card px-4 text-foreground/60 transition hover:bg-black/5 dark:hover:bg-accent md:flex"
        type="button"
        aria-label="Open command palette"
        title="Open command palette"
        onclick={() => void openNavbarPalette(paletteBindings)}
      >
        <Search size={24} />
        <span class="text-sm">Search ID...</span>
        <span class="ml-2 rounded-md border border-border bg-background px-2 py-0.5 text-xs text-foreground/45">
          Ctrl/Cmd K
        </span>
      </button>

      <a
        href="https://github.com/enzoblain/Veritas"
        aria-label="Open GitHub repository"
        title="GitHub"
        class="flex h-10 w-10 items-center justify-center rounded-xl text-foreground/70 transition hover:bg-black/5 hover:text-foreground dark:hover:bg-accent dark:hover:text-foreground"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          aria-hidden="true"
          class="h-[19px] w-[19px] fill-current"
        >
          <path
            d="M12 .297a12 12 0 0 0-3.79 23.39c.6.11.82-.26.82-.58v-2.25c-3.34.73-4.04-1.6-4.04-1.6a3.2 3.2 0 0 0-1.34-1.76c-1.09-.75.08-.73.08-.73a2.53 2.53 0 0 1 1.84 1.24 2.56 2.56 0 0 0 3.5 1 2.56 2.56 0 0 1 .76-1.61c-2.67-.3-5.47-1.33-5.47-5.93A4.65 4.65 0 0 1 5.6 7.75a4.32 4.32 0 0 1 .12-3.18s1-.32 3.3 1.23a11.5 11.5 0 0 1 6 0c2.3-1.55 3.3-1.23 3.3-1.23a4.32 4.32 0 0 1 .12 3.18 4.65 4.65 0 0 1 1.23 3.22c0 4.61-2.8 5.62-5.48 5.92a2.87 2.87 0 0 1 .82 2.22v3.3c0 .32.22.7.83.58A12 12 0 0 0 12 .297"
          />
        </svg>
      </a>

      <AnimatedThemeToggler
        class="flex h-10 w-10 cursor-pointer items-center justify-center rounded-xl text-foreground/70 transition hover:bg-black/5 hover:text-foreground dark:hover:bg-accent dark:hover:text-foreground"
        duration={450}
      />
    </div>
  </div>
</nav>

{#if isPaletteOpen}
  <div
    class="fixed inset-0 z-[70] flex items-center justify-center bg-black/45 backdrop-blur-[2px]"
    aria-hidden="true"
    onclick={() => closeNavbarPalette(paletteBindings)}
  >
    <div
      role="dialog"
      aria-modal="true"
      aria-label="Command palette"
      tabindex="-1"
      class="w-[92vw] max-w-3xl rounded-2xl border border-border bg-card shadow-2xl"
      onclick={(event) => event.stopPropagation()}
      onkeydown={(event) => {
        if (event.key === 'Escape') closeNavbarPalette(paletteBindings);
      }}
    >
      <div class="border-b border-border p-4">
        <input
          bind:this={paletteInput}
          type="text"
          bind:value={paletteId}
          placeholder="Enter Veritas ID..."
          class="w-full bg-transparent text-lg text-foreground placeholder:text-foreground/45 outline-none"
          onkeydown={(event) => handleNavbarPaletteInputKeydown(event, paletteBindings)}
          oninput={() => resetNavbarHistoryPreview(paletteBindings)}
        />
      </div>

      <div class="border-b border-border p-4">
        <button
          class="w-full cursor-pointer rounded-lg bg-primary px-4 py-2 text-sm font-medium text-primary-foreground transition hover:opacity-90 disabled:cursor-not-allowed disabled:opacity-50"
          type="button"
          onclick={() => submitNavbarPaletteSearch(paletteBindings)}
          disabled={!paletteId.trim()}
        >
          Search ID
        </button>
      </div>

      <div class="p-4">
        <p class="mb-2 px-1 text-xs font-semibold uppercase tracking-wide text-foreground/55">History</p>

        <div class="space-y-1">
          {#if filteredHistory.length === 0}
            <p class="rounded-lg px-3 py-2 text-sm text-foreground/50">No history match.</p>
          {:else}
            {#each filteredHistory.slice(0, 5) as item, index (item.id)}
              <button
                type="button"
                class={`flex w-full items-center justify-between rounded-lg px-3 py-2 text-left transition ${activeHistoryIndex === index ? 'bg-accent text-foreground' : 'text-foreground/85 hover:bg-accent'}`}
                onclick={() => selectNavbarHistoryItem(paletteBindings, item)}
              >
                <span class="text-sm font-medium">{item.id}</span>
                <span class="text-xs text-foreground/55">{item.product} • {timeAgo(item.lastCheck)}</span>
              </button>
            {/each}
          {/if}
        </div>
      </div>
    </div>
  </div>
{/if}