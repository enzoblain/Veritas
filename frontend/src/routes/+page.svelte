<script lang="ts">
  import InteractiveHoverButton from '$lib/components/magic/interactive-hover-button/interactive-hover-button.svelte';
  import Footer from '$lib/components/layout/Footer.svelte';
  import MagicCard from '$lib/components/magic/magic-card/magic-card.svelte';
	import { theme } from '$lib/stores/theme.svelte';
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import { ArrowRight } from '@lucide/svelte';
  import { Factory, ChartColumn, Target } from '@lucide/svelte';
  import { attachHomeSearchShortcuts } from '$lib/features/search/home';
  import { ChevronRight } from '@lucide/svelte';
  import { steps } from '$lib/utils/steps';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
  import { Shield, BookOpen, Users, Lock } from '@lucide/svelte';
	import AnimatedGridPattern from '$lib/components/magic/animated-grid-pattern/animated-grid-pattern.svelte';
	import type { Product } from '$lib/types/product';
	import { getMockProduct } from '$lib/services/product';
	import ProductContent from '$lib/components/product/ProductContent.svelte';
	import ProductBoxContainer from '$lib/components/product/ProductBoxContainer.svelte';

  let searchId = '';
  let searchInput: HTMLInputElement | null = null;

  function performSearch(): void {
    if (!searchId.trim()) return;
    goto(`/product/${searchId}`);
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

  interface Benefit {
    icon: any;
    title: string;
    description: string;
  }

  const benefits: Benefit[] = [
    {
      icon: Shield,
      title: 'Price Transparency',
      description: 'See the exact price at every stage, from producer to retailer.'
    },
    {
      icon: BookOpen,
      title: 'Margin Visibility',
      description: 'Understand how much each actor in the chain profits from the product.'
    },
    {
      icon: Users,
      title: 'Fair Value Ensured',
      description: 'Consumers and producers make informed decisions based on real data.'
    },
    {
      icon: Lock,
      title: 'Immutable Pricing',
      description: 'Blockchain-backed price history that cannot be altered or hidden.'
    }
  ];

  interface Feature {
    icon: any;
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
      icon: ChartColumn,
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

<div class="w-full">
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
              onclick={() => goto(`/product/VRT-2024-001`)}
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

  <section id="how-it-works" class="relative overflow-hidden bg-background px-6 py-12 sm:py-16">
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

  <section class="relative overflow-hidden bg-background px-6 py-12 sm:py-16">
    <div class="mx-auto max-w-5xl">
      <ProductBoxContainer>
        <ProductContent product={getMockProduct()} />
      </ProductBoxContainer>
    </div>
  </section>

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
  <Footer />
</div>
