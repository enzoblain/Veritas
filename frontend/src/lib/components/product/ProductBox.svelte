<script lang="ts">
  import type { Product } from '$lib/types/product';
  import BorderBeam from '$lib/components/magic/border-beam/border-beam.svelte';
  import DotPattern from '$lib/components/magic/dot-pattern/dot-pattern.svelte';
  import { CheckCircle2, MapPin, Truck, Clock } from '@lucide/svelte';
  import { theme } from '$lib/stores/theme.svelte';

  let { product }: { product: Product } = $props();

  function getMultiplierInfo(currentPrice: number, originalPrice: number) {
    const multiplier = currentPrice / originalPrice;

    let color = '';
    let label = '';

    if (multiplier >= 1 && multiplier < 1.5) {
      color = '#3b82f6';
      label = 'Excellent';
    } else if (multiplier >= 1.5 && multiplier < 2) {
      color = '#22c55e';
      label = 'Good';
    } else if (multiplier >= 2 && multiplier < 3) {
      color = '#eab308';
      label = 'Fair';
    } else {
      color = '#ef4444';
      label = 'High Markup';
    }

    return { multiplier: multiplier.toFixed(2), color, label };
  }

  function formatPrice(price: number): string {
    return `$${price.toFixed(2)}`;
  }

  function formatDate(timestamp: number): string {
    return new Date(timestamp).toLocaleDateString();
  }

  const multiplierInfo = $derived(getMultiplierInfo(product.currentPrice, product.originalPrice));
</script>

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
          <h3 class="text-2xl font-bold">{product.name}</h3>
          <p class="mt-2 text-sm text-foreground/60">ID: <code class="text-foreground font-mono text-sm">{product.id}</code></p>
        </div>
        {#if product.isVerified}
          <div class="flex items-center gap-2 rounded-full border border-green-500/30 bg-green-500/10 px-3 py-1.5 text-sm font-medium text-green-500">
            <CheckCircle2 size={24} />
            Verified authentic
          </div>
        {/if}
      </div>
      <div class="mb-10 grid gap-4 sm:grid-cols-3">
        <div class="rounded-lg border border-border/50 bg-card/40 p-4">
          <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Category</p>
          <div class="mt-2 flex items-center gap-2">
            <MapPin size={20} class="text-foreground" />
            <p class="font-semibold">{product.category}</p>
          </div>
        </div>
        <div class="rounded-lg border border-border/50 bg-card/40 p-4">
          <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Current Price</p>
          <div class="mt-2 flex items-center gap-2">
            <Truck size={20} class="text-foreground" />
            <p class="font-semibold text-sm">{formatPrice(product.currentPrice)}</p>
          </div>
        </div>
        <div class="rounded-lg border border-border/50 bg-card/40 p-4">
          <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Last Update</p>
          <div class="mt-2 flex items-center gap-2">
            <Clock size={20} class="text-foreground" />
            <p class="font-semibold text-sm">{formatDate(product.lastUpdated)}</p>
          </div>
        </div>
      </div>
      <div class="flex flex-col lg:flex-row items-center gap-8">
        <div class="flex-1">
          <h4 class="mb-6 font-semibold">Price at Each Stage</h4>
          <div class="space-y-4">
            {#each product.priceHistory as entry, index (index)}
              <div class="rounded-lg border border-border/30 bg-card/30 p-3">
                <div class="flex items-center justify-between">
                  <div>
                    <p class="text-sm font-semibold text-foreground/90">{formatPrice(entry.amount)}</p>
                    <p class="text-xs text-foreground/70">{entry.actor}</p>
                  </div>
                  <div class="text-right">
                    <p class="text-xs font-medium text-foreground/70 uppercase">{entry.role}</p>
                    {#if entry.margin !== undefined && entry.margin > 0}
                      <p class="text-xs font-semibold text-foreground/60">+{formatPrice(entry.margin)}</p>
                    {:else}
                      <p class="text-xs font-semibold text-foreground/60">Base Price</p>
                    {/if}
                  </div>
                </div>
              </div>
            {/each}
          </div>
        </div>

        <div class="flex-1 flex items-center justify-center">
          <div class="text-center">
            <p class="text-xs font-medium uppercase tracking-wide text-foreground/70">Current vs Original Price</p>
            <p class="mt-2 text-6xl font-bold" style="color: {multiplierInfo.color}">
              {multiplierInfo.multiplier}x
            </p>
            <p class="mt-2 text-sm font-medium text-foreground/60">{multiplierInfo.label}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
