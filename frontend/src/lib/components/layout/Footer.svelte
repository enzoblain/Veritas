<script lang="ts">
  import { Github, Mail } from '@lucide/svelte';
  import { BlurFade } from '$lib/components/magic/blur-fade';

  const currentYear = new Date().getFullYear();

  const links = [
    { label: 'Documentation', href: '#' },
    { label: 'GitHub', href: '#', icon: Github },
    { label: 'Contact', href: 'mailto:hello@veritas.io', icon: Mail }
  ];

  const legalLinks = [
    { label: 'Privacy Policy', href: '#' },
    { label: 'Terms of Service', href: '#' }
  ];
</script>

<footer class="relative overflow-hidden border-t border-border/50 bg-background px-6 py-8">
  <div class="mx-auto max-w-5xl">
    <div class="grid gap-12 md:grid-cols-3">
      <BlurFade delay={0} duration={0.5} direction="up">
        <div>
          <h3 class="text-2xl font-bold">Veritas</h3>
          <p class="mt-2 text-sm text-foreground">
            Know every price. Understand every margin. Demand transparency.
          </p>
        </div>
      </BlurFade>

      <BlurFade delay={0.1} duration={0.5} direction="up">
        <div>
          <h4 class="font-semibold">Resources</h4>
          <ul class="mt-4 space-y-2">
            {#each links as link}
              <li>
                <a
                  href={link.href}
                  class="inline-flex items-center gap-2 text-sm text-foreground/70 transition hover:text-foreground"
                >
                  {link.label}
                  {#if link.icon}
                    <link.icon size={20} />
                  {/if}
                </a>
              </li>
            {/each}
          </ul>
        </div>
      </BlurFade>

      <BlurFade delay={0.2} duration={0.5} direction="up">
        <div>
          <h4 class="font-semibold">Legal</h4>
          <ul class="mt-4 space-y-2">
            {#each legalLinks as link}
              <li>
                <a href={link.href} class="text-sm text-foreground/70 transition hover:text-foreground">
                  {link.label}
                </a>
              </li>
            {/each}
          </ul>
        </div>
      </BlurFade>
    </div>

    <div class="mt-12 border-t border-border/50 pt-8">
      <div class="flex flex-col items-center justify-between gap-4 sm:flex-row">
        <p class="text-sm text-foreground/50">
          &copy; {currentYear} Veritas. All rights reserved.
        </p>
        <p class="text-sm text-foreground/50">
          Built with <span class="text-accent">❤</span> for transparency
        </p>
      </div>
    </div>
  </div>
</footer>
