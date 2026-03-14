<script lang="ts">
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import BorderBeam from '$lib/components/magic/border-beam/border-beam.svelte';
  import DotPattern from '$lib/components/magic/dot-pattern/dot-pattern.svelte';
  import { CheckCircle2, MapPin, Truck, Clock } from '@lucide/svelte';
  import { theme } from '../stores/theme.svelte';

  const productData = {
    name: 'Organic Carrot',
    verityId: 'VRT-2024-CARROT',
    status: 'authentic',
    origin: 'Local Farm',
    lastTransfer: 'Available in Store',
    lastTransferDate: '2024-03-14',
    timeline: [
      { stage: 'Retailer', location: 'Supermarket', price: '$1.99', margin: '+$1.09' },
      { stage: 'Wholesaler', location: 'Distribution Center', price: '$0.90', margin: '+$0.40' },
      { stage: 'Farmer', location: 'Farm', price: '$0.50', margin: 'Initial Price' }
    ]
  };

  let containerRef: HTMLElement | null = $state(null);
  let factRefs: (HTMLDivElement | null)[] = $state([null, null, null]);

  const initialPrice = 0.50;

  function getPriceMultiplier(priceStr: string): string {
    const price = parseFloat(priceStr.replace('$', ''));
    const multiplier = price / initialPrice;
    return multiplier.toFixed(2) + 'x';
  }

  function getMultiplierInfo(priceStr: string) {
    const price = parseFloat(priceStr.replace('$', ''));
    const multiplier = price / initialPrice;

    let color = '';
    let label = '';

    if (multiplier >= 1 && multiplier < 1.5) {
      color = 'text-blue-500';
      label = 'Excellent';
    } else if (multiplier >= 1.5 && multiplier < 2) {
      color = 'text-green-500';
      label = 'Good';
    } else if (multiplier >= 2 && multiplier < 3) {
      color = 'text-yellow-500';
      label = 'Fair';
    } else {
      color = 'text-red-500';
      label = 'High Markup';
    }
    
    return { multiplier: multiplier.toFixed(2), color, label };
  }
</script>

<section class="relative overflow-hidden bg-background px-6 py-12 sm:py-16" bind:this={containerRef}>
  <div class="mx-auto max-w-5xl">
    <BlurFade delay={0} duration={0.5} direction="up">
      <div class="mb-4 text-center">
        <div class="mb-4 inline-flex rounded-full border border-border/70 bg-card/40 px-3 py-1 backdrop-blur-sm">
          <span class="text-xs font-medium text-foreground/70">Example</span>
        </div>
        <h2 class="text-4xl font-bold tracking-tight md:text-5xl">
          Price Transparency & Profit Visibility
        </h2>
        <p class="mt-4 text-lg text-foreground/60">
          Understand how prices change and margins grow at each stage of the supply chain
        </p>
      </div>
    </BlurFade>

    <div class="mt-16">
      <BlurFade delay={0.1} duration={0.5} direction="left">
        <div class="overflow-visible rounded-2xl border border-border/60 bg-gradient-to-b from-card/60 to-card/20 p-8 backdrop-blur-sm sm:p-10 relative">
          <BorderBeam size={200} duration={12} delay={0} colorFrom={theme.beamColorFrom} colorTo={theme.beamColorTo} />
          <div class="pointer-events-none absolute inset-0 rounded-2xl" aria-hidden="true">
            <DotPattern
              width={32}
              height={32}
              cx={2}
              cy={2}
              cr={2}
              class="fill-current opacity-50"
              style="mask-image: radial-gradient(ellipse 60% 60% at center, white 0%, transparent 100%);"
            />
          </div>
          <div class="relative z-10">
            <div class="mb-8 flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
            <div>
              <h3 class="text-2xl font-bold">{productData.name}</h3>
              <p class="mt-2 text-sm text-foreground/60">ID: <code class="text-foreground font-mono text-sm">{productData.verityId}</code></p>
            </div>
            {#if productData.status === 'authentic'}
              <div class="flex items-center gap-2 rounded-full border border-green-500/30 bg-green-500/10 px-3 py-1.5 text-sm font-medium text-green-500">
                <CheckCircle2 size={24} />
                Verified authentic
              </div>
            {/if}
          </div>
          <div class="mb-10 grid gap-4 sm:grid-cols-3">
            <BlurFade delay={0.2} duration={0.5} direction="up">
              <div class="rounded-lg border border-border/50 bg-card/40 p-4" bind:this={factRefs[0]}>
                <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Origin</p>
                <div class="mt-2 flex items-center gap-2">
                  <MapPin size={20} class="text-foreground" />
                  <p class="font-semibold">{productData.origin}</p>
                </div>
              </div>
            </BlurFade>
            <BlurFade delay={0.3} duration={0.5} direction="up">
              <div class="rounded-lg border border-border/50 bg-card/40 p-4" bind:this={factRefs[1]}>
                <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Last Transfer</p>
                <div class="mt-2 flex items-center gap-2">
                  <Truck size={20} class="text-foreground" />
                  <p class="font-semibold text-sm">{productData.lastTransfer}</p>
                </div>
              </div>
            </BlurFade>
            <BlurFade delay={0.4} duration={0.5} direction="up">
              <div class="rounded-lg border border-border/50 bg-card/40 p-4" bind:this={factRefs[2]}>
                <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Last Update</p>
                <div class="mt-2 flex items-center gap-2">
                  <Clock size={20} class="text-foreground" />
                  <p class="font-semibold text-sm">{productData.lastTransferDate}</p>
                </div>
              </div>
            </BlurFade>
          </div>
          <div class="flex flex-column items-center">
            <div>
              <h4 class="mb-6 font-semibold">Price at Each Stage</h4>
              <div class="flex gap-12">
                <div class="space-y-3 ml-1">
                  {#each productData.timeline as entry, index (index)}
                    <BlurFade delay={0.5 + index * 0.1} duration={0.5} direction="left">
                      <div>
                        <div class="text-lg font-bold text-foreground/90">
                          {entry.price}
                        </div>
                        <p class="text-sm font-semibold">{entry.stage}</p>
                        <p class="mt-1 text-xs text-foreground/70">{entry.margin}</p>
                      </div>
                    </BlurFade>
                  {/each}
                </div>
              </div>
            </div>

              <div class="flex flex-1 items-center justify-center">
                {#if true}
                  {@const info = getMultiplierInfo(productData.timeline[0].price)}
                  <div class="text-center">
                    <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Retail vs Farm Price Ratio</p>
                    <p class="mt-2 text-6xl font-bold" style="color: {info.color === 'text-blue-500' ? '#3b82f6' : info.color === 'text-green-500' ? '#22c55e' : info.color === 'text-yellow-500' ? '#eab308' : '#ef4444'}">
                      {info.multiplier}x
                    </p>
                    <p class="mt-2 text-sm font-medium text-foreground/60">{info.label}</p>
                  </div>
                {/if}
              </div>
          </div>
          </div>
        </div>
      </BlurFade>
    </div>
  </div>
</section>
