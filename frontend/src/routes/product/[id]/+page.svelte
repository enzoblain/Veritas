<script lang="ts">
  import ErrorPage from '$lib/components/errors/ErrorPage.svelte';
  import ProductBoxContainer from '$lib/components/product/ProductBoxContainer.svelte';
  import ProductContent from '$lib/components/product/ProductContent.svelte';
  import ProductSkeletonContent from '$lib/components/product/ProductSkeletonContent.svelte';
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import { page } from '$app/state';
  import { getProduct } from '$lib/services/product';
  import type { Product } from '$lib/types/product';

  const id = page.params.id || '';

  let product: Product | null | undefined = $state(undefined);

  $effect(() => {
    if (!id) {
      product = null;
      return;
    }

    (async () => {
      try {
        product = await getProduct(id);
      } catch {
        product = null;
      }
    })();
  });
</script>

{#if product === null}
  <ErrorPage
    title="Product Not Found"
    message="The product you're looking for couldn't be found. This might happen if the link is broken or if you made a small mistake."
  />

{:else}
  <section class="relative overflow-hidden bg-background px-6 py-12 sm:py-16 pt-24 sm:pt-32">
    <div class="mx-auto max-w-5xl">

      <BlurFade delay={0} duration={0.5} direction="up">
        <div class="mb-4 text-center">
          <div class="mb-4 inline-flex rounded-full border border-border/70 bg-card/40 px-3 py-1 backdrop-blur-sm">
            <span class="text-xs font-medium text-foreground/70">
              Product Details
            </span>
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
        <ProductBoxContainer>
          {#if product === undefined}
            <ProductSkeletonContent />
          {:else}
            <ProductContent {product} />
          {/if}
        </ProductBoxContainer>
      </div>

    </div>
  </section>
{/if}