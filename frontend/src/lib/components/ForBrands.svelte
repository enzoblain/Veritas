<script lang="ts">
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import { ArrowRight } from 'lucide-svelte';
  import type { ComponentType } from 'svelte';
  import { Factory, BarChart3, Target } from 'lucide-svelte';

  interface Feature {
    icon: ComponentType;
    title: string;
    description: string;
  }

  const features: Feature[] = [
    {
      icon: Factory,
      title: 'For Producers',
      description: 'Issue Veritas IDs to track your product pricing from farm to consumer.'
    },
    {
      icon: BarChart3,
      title: 'For Distributors',
      description: 'Monitor price evolution and document margins at each distribution point.'
    },
    {
      icon: Target,
      title: 'For Retailers',
      description: 'Show customers exact pricing history and build trust through transparency.'
    }
  ];
</script>

<section class="relative overflow-hidden bg-background px-6 py-12 sm:py-16">
  <div class="mx-auto max-w-5xl">
    <BlurFade delay={0} duration={0.5} direction="up">
      <div class="mb-4 text-center">
        <div class="mb-4 inline-flex rounded-full border border-border/70 bg-card/40 px-3 py-1 backdrop-blur-sm">
          <span class="text-xs font-medium text-foreground/70">For businesses</span>
        </div>
        <h2 class="text-4xl font-bold tracking-tight md:text-5xl">
          Transparent Supply Chains
        </h2>
        <p class="mt-4 text-lg text-foreground/60">
          Veritas empowers businesses to optimize pricing and build consumer trust through transparency
        </p>
      </div>
    </BlurFade>

    <div class="mt-16 grid gap-6 md:grid-cols-3">
      {#each features as feature, index (index)}
        <BlurFade delay={0.1 + index * 0.05} duration={0.5} direction={index % 2 === 0 ? 'left' : 'right'}>
          <div class="group relative overflow-hidden rounded-2xl border border-border/60 bg-card/40 p-8 backdrop-blur-sm transition-all duration-300 hover:border-accent/50 hover:bg-card/60">
            <div class="mb-4 inline-flex rounded-lg border border-border/30 p-3">
              <feature.icon size={28} class="text-foreground" />
            </div>
            <h3 class="mb-2 text-lg font-semibold">{feature.title}</h3>
            <p class="text-sm text-foreground">{feature.description}</p>
          </div>
        </BlurFade>
      {/each}
    </div>

    <BlurFade delay={0.3} duration={0.5} direction="up">
      <div class="mt-12 text-center">
        <a
          href="mailto:enzoblain@proton.me"
          class="inline-flex items-center gap-2 rounded-lg bg-primary px-6 py-3 font-semibold text-primary-foreground transition-all hover:opacity-90 hover:shadow-lg"
        >
          Get in touch with our team
          <ArrowRight size={20} />
        </a>
      </div>
    </BlurFade>
  </div>
</section>
