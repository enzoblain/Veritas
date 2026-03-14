<script lang="ts">
  import { goto } from '$app/navigation';
  import { AnimatedGridPattern } from '$lib/components/magic/animated-grid-pattern';
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import InteractiveHoverButton from '$lib/components/magic/interactive-hover-button/interactive-hover-button.svelte';
  import { onMount } from 'svelte';
  import { attachHomeSearchShortcuts } from '$lib/home-search';
  import { ChevronRight } from 'lucide-svelte';

  let searchId = '';
  let searchInput: HTMLInputElement | null = null;

  function performSearch(): void {
    if (!searchId.trim()) return;
    goto(`/product/${searchId}`);
  }

  function loadExampleProduct(): void {
    searchId = 'VRT-2024-001';
    setTimeout(() => performSearch(), 100);
  }

  onMount(() => {
    return attachHomeSearchShortcuts({
      getInput: () => searchInput,
      getValue: () => searchId,
      setValue: (value) => {
        searchId = value;
      }
    });
  });
</script>

<section class="relative flex min-h-screen w-full items-center justify-center overflow-hidden bg-background px-6 py-20">
  <div class="pointer-events-none absolute inset-0 overflow-hidden" aria-hidden="true">
    <AnimatedGridPattern
      width={48}
      height={48}
      numSquares={65}
      maxOpacity={0.24}
      duration={6}
      repeatDelay={0.8}
      class="inset-x-0 inset-y-[-40%] h-[180%] w-full skew-y-6 text-foreground/35 [mask-image:radial-gradient(ellipse_at_center,white_25%,transparent_70%)]"
    />
  </div>

  <div class="relative z-10 w-full max-w-3xl">
    <BlurFade delay={0} duration={0.6} direction="up">
      <div class="flex flex-col items-center gap-1 text-center">
        <div class="mb-2 inline-flex items-center gap-2 rounded-full border border-border/70 bg-card/40 px-3 py-1 backdrop-blur-sm">
          <span class="text-xs font-medium text-foreground/70">Welcome to Veritas</span>
          <div class="h-1 w-1 rounded-full bg-accent/50"></div>
        </div>
      </div>
    </BlurFade>

    <BlurFade delay={0.1} duration={0.6} direction="up">
      <h1 class="mb-6 text-center text-5xl font-bold tracking-tight md:text-7xl">
        <span class="bg-gradient-to-r from-foreground via-foreground to-foreground/70 bg-clip-text text-transparent">
          Track Prices. Know Margins. Ensure Fairness.
        </span>
      </h1>
    </BlurFade>

    <BlurFade delay={0.2} duration={0.6} direction="up">
      <p class="mx-auto mb-12 max-w-xl text-center text-lg leading-relaxed text-foreground/60">
        See exactly how prices evolve through the supply chain. Understand every margin and built-in cost. Demand transparency.
      </p>
    </BlurFade>

    <BlurFade delay={0.3} duration={0.6} direction="up">
      <div class="mx-auto mb-8 max-w-md">
        <div class="rounded-2xl border border-border/60 bg-card/50 p-1.5 shadow-lg backdrop-blur-sm transition-all duration-300 hover:border-border/80 hover:bg-card/70">
          <div class="flex items-center gap-2 w-full">
            <input
              bind:this={searchInput}
              type="text"
              bind:value={searchId}
              placeholder="Paste your Veritas ID here..."
              onkeydown={(e) => {
                if (e.key === 'Enter') performSearch();
              }}
              class="flex-1 bg-transparent px-5 py-4 text-sm text-foreground placeholder:text-foreground/35 outline-none"
            />
            <button
              onclick={performSearch}
              class="flex items-center gap-2 rounded-xl bg-primary px-6 py-3 font-semibold text-primary-foreground shadow-md transition-all duration-200 hover:shadow-lg hover:opacity-90 active:scale-95"
            >
              Search
              <ChevronRight size={24} />
            </button>
          </div>
        </div>
        <p class="mt-4 text-center text-xs text-foreground/40">
          Try example: <button
            onclick={loadExampleProduct}
            class="font-semibold text-foreground underline transition cursor-pointer hover:text-foreground/80"
          >
            VRT-2024-001
          </button>
        </p>
      </div>
    </BlurFade>

    <BlurFade delay={0.4} duration={0.6} direction="up">
      <div class="flex flex-col items-center justify-center gap-3 sm:flex-row">
        <a href="#how-it-works">
          <InteractiveHoverButton class="text-sm">
            Learn how it works
          </InteractiveHoverButton>
        </a>
      </div>
    </BlurFade>
  </div>
</section>
