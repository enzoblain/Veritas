<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation'; 
  import { AnimatedGridPattern } from '$lib/components/magic/animated-grid-pattern';
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import { attachHomeSearchShortcuts } from '$lib/home-search';

  let id = "";
  let searchInput: HTMLInputElement | null = null;

  function searchProduct():  void {
    if (!id.trim()) return;

    goto(`/product/${id}`);
  }

  onMount(() => {
    return attachHomeSearchShortcuts({
      getInput: () => searchInput,
      getValue: () => id,
      setValue: (value) => {
        id = value;
      }
    });
  });
</script>

<div class="relative flex min-h-screen w-full justify-center bg-background px-6 pt-[22vh]">
  <div class="pointer-events-none absolute inset-0 overflow-hidden" aria-hidden="true">
    <AnimatedGridPattern
      width={48}
      height={48}
      numSquares={55}
      maxOpacity={0.28}
      duration={5}
      repeatDelay={0.7}
      class="inset-x-0 inset-y-[-30%] h-[170%] w-full skew-y-6 text-foreground/40 [mask-image:radial-gradient(ellipse_at_center,white_22%,transparent_75%)]"
    />
  </div>

  <div class="relative z-10 w-full max-w-2xl flex flex-col items-center gap-8">
    <div class="flex flex-col items-center gap-3 text-center">
      <BlurFade delay={0} duration={0.5} direction="up">
        <h1 class="text-6xl font-semibold tracking-tight text-primary">Veritas</h1>
      </BlurFade>
      <BlurFade delay={0.1} duration={0.5} direction="up">
        <p class="max-w-md text-sm leading-6 text-foreground/60">
          Track the history of a product through its Veritas ID.
        </p>
      </BlurFade>
    </div>

    <div class="w-full">
      <BlurFade delay={0.2} duration={0.5} direction="up" class="w-full">
        <div class="w-full rounded-2xl border border-border bg-card p-2 shadow-sm">
          <div class="flex items-center">
            <input
              bind:this={searchInput}
              type="text"
              data-veritas-search
              bind:value={id}
              placeholder="Enter Veritas ID"
              class="h-12 flex-1 bg-transparent px-4 text-sm text-foreground placeholder:text-foreground/35 outline-none"
              onkeydown={(e) => { (e.key === "Enter") ? searchProduct() : null }}
            />

            <button
              class="h-12 cursor-pointer rounded-xl bg-primary px-5 text-sm font-medium text-primary-foreground transition hover:opacity-90"
              onclick={searchProduct}
            >
              Search
            </button>
          </div>
        </div>
      </BlurFade>
    </div>
  </div>
</div>
