<script lang="ts">
  import { goto } from '$app/navigation';
  import { ChevronRight } from '@lucide/svelte';
  import { AnimatedGridPattern } from '$lib/components/magic/animated-grid-pattern';
  import { BlurFade } from '$lib/components/magic/blur-fade';
  import { theme } from '$lib/stores/theme.svelte'
  import PulsatingButton from '$lib/components/magic/pulsating-button/pulsating-button.svelte';

  let { title, message}: {
    title: string;
    message: string;
  } = $props();
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
          <span class="text-xs font-medium text-foreground/70">Error</span>
          <div class="h-1 w-1 rounded-full" style="background-color: {theme.accentColor}"></div>
        </div>
      </div>
    </BlurFade>

    <BlurFade delay={0.1} duration={0.6} direction="up">
      <h1 class="mb-6 text-center text-5xl font-bold tracking-tight md:text-7xl">
        <span class="bg-gradient-to-r from-foreground via-foreground to-foreground/70 bg-clip-text text-transparent">
          {title}
        </span>
      </h1>
    </BlurFade>

    <BlurFade delay={0.2} duration={0.6} direction="up">
      <p class="mx-auto mb-12 max-w-xl text-center text-lg leading-relaxed text-foreground/60">
        {message}
      </p>
    </BlurFade>

    <BlurFade delay={0.3} duration={0.6} direction="up">
      <div class="mb-12 flex flex-col justify-center gap-4 sm:flex-row">
        <button onclick={() => goto('/')} class="inline-block">
          <PulsatingButton
            duration="2s"
            class="group gap-2 px-8 py-4 font-semibold shadow-lg hover:shadow-2xl hover:shadow-primary/40"
          >
            <span class="flex items-center gap-2 whitespace-nowrap">
              Back to Home
              <ChevronRight
                size={18}
                class="transition-transform duration-300 group-hover:translate-x-1"
              />
            </span>
          </PulsatingButton>
        </button>

        <a
          href="mailto:enzoblain@proton.me"
          class="inline-flex cursor-pointer items-center justify-center rounded-xl border border-border/60 bg-gradient-to-br from-card/60 to-card/40 px-8 py-4 font-semibold text-foreground transition-all duration-300 hover:border-border/100 hover:from-card/80 hover:to-card/60 hover:shadow-lg"
        >
          Contact Support
        </a>
      </div>
    </BlurFade>

    <BlurFade delay={0.4} duration={0.6} direction="up">
      <div class="text-center">
        <p class="mb-4 text-sm text-foreground/40">
          Quick suggestions:
        </p>

        <div class="flex flex-wrap justify-center gap-3">
          <button
            onclick={() => goto('/')}
            class="rounded-lg border border-border/40 bg-card/30 px-4 py-2 text-sm font-medium text-foreground/70 transition-all duration-200 hover:border-border/60 hover:bg-card/50 hover:text-foreground"
          >
            Home
          </button>

          <button
            onclick={() => goto('/faq')}
            class="rounded-lg border border-border/40 bg-card/30 px-4 py-2 text-sm font-medium text-foreground/70 transition-all duration-200 hover:border-border/60 hover:bg-card/50 hover:text-foreground"
          >
            FAQ
          </button>
        </div>
      </div>
    </BlurFade>
  </div>
</section>