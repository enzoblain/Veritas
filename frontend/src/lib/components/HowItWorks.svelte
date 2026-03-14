<script lang="ts">
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import InteractiveHoverButton from '$lib/components/magic/interactive-hover-button/interactive-hover-button.svelte';
  import { steps } from '$lib/utils/steps';

  let containerRef: HTMLElement | null = $state(null);

</script>

<section id="how-it-works" class="relative overflow-hidden bg-background px-6 py-12 sm:py-16" bind:this={containerRef}>
  <div class="mx-auto max-w-5xl">
    <BlurFade delay={0} duration={0.5} direction="up">
      <div class="mb-4 text-center">
        <div class="mb-4 inline-flex rounded-full border border-border/70 bg-card/40 px-3 py-1 backdrop-blur-sm">
          <span class="text-xs font-medium text-foreground/70">How it works</span>
        </div>
        <h2 class="text-4xl font-bold tracking-tight md:text-5xl">
          See The Real Price Story
        </h2>
        <p class="mt-4 text-lg text-foreground/60">
          Understand pricing in seconds
        </p>
      </div>
    </BlurFade>

    <div class="mt-16 grid gap-8 md:grid-cols-3 auto-rows-fr" role="presentation">
      {#each steps as step, index (index)}
        <BlurFade delay={0.1 + index * 0.1} duration={0.5} direction={index % 2 === 0 ? 'left' : 'right'}>
          <div
            class="group relative overflow-hidden rounded-2xl border border-border/60 bg-card/40 p-8 backdrop-blur-sm transition-all duration-300 hover:border-border/80 hover:bg-card/60"
          >
            <div
              class="absolute inset-0 -z-10 bg-gradient-to-b from-accent/5 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100"
            ></div>
            <div class="mb-4 inline-flex rounded-xl border border-border/30 p-3">
              <step.icon size={32} class="text-foreground" />
            </div>
            <h3 class="mb-2 text-xl font-semibold">{step.title}</h3>
            <p class="text-sm leading-relaxed text-foreground">{step.description}</p>
            <div class="mt-6 flex items-center gap-2">
              <div class="h-1 w-8 rounded-full bg-accent/40"></div>
              <span class="text-xs font-medium text-accent/60">Step {index + 1}</span>
            </div>
          </div>
        </BlurFade>
      {/each}
    </div>
  </div>
</section>
