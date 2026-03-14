<script lang="ts">
  import BorderBeam from '$lib/components/magic/border-beam/border-beam.svelte';
  import DotPattern from '$lib/components/magic/dot-pattern/dot-pattern.svelte';
  import { theme } from '$lib/stores/theme.svelte';

  let containerRef: HTMLElement | null = $state(null);
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

            <!-- header -->
            <div class="mb-8 flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
              <div class="space-y-2">
                <div class="h-7 w-48 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                <div class="h-4 w-32 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
              </div>
              <div class="h-8 w-32 rounded-full bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
            </div>

            <!-- info cards -->
            <div class="mb-10 grid gap-4 sm:grid-cols-3">
              {#each Array(3) as _}
                <div class="rounded-lg border border-border/50 bg-card/40 p-4 space-y-2">
                  <div class="h-3 w-20 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                  <div class="h-5 w-24 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                </div>
              {/each}
            </div>

            <div class="flex flex-col lg:flex-row items-center gap-8">

              <!-- price history -->
              <div class="flex-1 space-y-4">
                <div class="h-5 w-40 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>

                {#each Array(4) as _}
                  <div class="rounded-lg border border-border/30 bg-card/30 p-3 flex justify-between">
                    <div class="space-y-2">
                      <div class="h-4 w-20 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                      <div class="h-3 w-24 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                    </div>

                    <div class="space-y-2 text-right">
                      <div class="h-3 w-16 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                      <div class="h-3 w-12 rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                    </div>
                  </div>
                {/each}
              </div>

              <!-- multiplier -->
              <div class="flex-1 flex items-center justify-center">
                <div class="text-center space-y-3">
                  <div class="h-4 w-36 mx-auto rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                  <div class="h-16 w-24 mx-auto rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                  <div class="h-4 w-20 mx-auto rounded bg-slate-300 dark:bg-slate-700 animate-pulse"></div>
                </div>
              </div>

            </div>

          </div>
        </div>