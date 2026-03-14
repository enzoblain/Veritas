<script lang="ts">
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import { benefits } from '$lib/config/benefits';
	import { theme } from '../stores/theme.svelte';
  import MagicCard from '$lib/components/magic/magic-card/magic-card.svelte';
</script>

<section class="relative overflow-hidden bg-background px-6 py-12 sm:py-16">
  <div class="mx-auto max-w-5xl">
    <BlurFade delay={0} duration={0.5} direction="up">
      <div class="mb-4 text-center">
        <div class="mb-4 inline-flex rounded-full border border-border/70 bg-card/40 px-3 py-1 backdrop-blur-sm">
          <span class="text-xs font-medium text-foreground/70">Why Veritas</span>
        </div>
        <h2 class="text-4xl font-bold tracking-tight md:text-5xl">
          Price Transparency Done Right
        </h2>
        <p class="mt-4 text-lg text-foreground/60">
          Why businesses and consumers need supply chain pricing visibility
        </p>
      </div>
    </BlurFade>

    <div class="mt-16 grid gap-6 md:grid-cols-2 auto-rows-fr">
      {#each benefits as benefit, index (index)}
        <BlurFade delay={0.1 + (index % 2) * 0.05 + Math.floor(index / 2) * 0.1} duration={0.5} direction={index % 2 === 0 ? 'left' : 'right'}>
          <MagicCard 
            class="rounded-3xl border dark:border-white/20 border-black/20" 
            gradientSize={150} 
            gradientColor="#1a1a2e" 
            gradientFrom={theme.gradientFrom}
            gradientTo={theme.gradientTo}
            gradientOpacity={theme.gradientOpacity}>
            <div class="p-8">
              <div class="mb-4 inline-flex rounded-lg border border-border/30 p-3">
                <benefit.icon size={28} class="text-foreground" />
              </div>
              <h3 class="mb-2 text-xl font-semibold">{benefit.title}</h3>
              <p class="text-sm leading-relaxed text-foreground">{benefit.description}</p>
            </div>
          </MagicCard>
        </BlurFade>
      {/each}
    </div>
  </div>
</section>
