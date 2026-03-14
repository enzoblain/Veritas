<script lang="ts">
  import BorderBeam from '$lib/components/magic/border-beam/border-beam.svelte';
  import DotPattern from '$lib/components/magic/dot-pattern/dot-pattern.svelte';
  import { theme } from '$lib/stores/theme.svelte';
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
    <slot />
  </div>
</div>
