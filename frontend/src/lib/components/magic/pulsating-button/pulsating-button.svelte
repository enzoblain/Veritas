<script lang="ts">
	import { cn } from "$lib/utils";
	import type { Snippet } from "svelte";

	interface PulsatingButtonProps {
		children: Snippet;
		class?: string;
		pulseColor?: string;
		duration?: string;
	}

	let {
		class: className,
		children,
		pulseColor = "#808080",
		duration = "1.5s",
		...props
	}: PulsatingButtonProps = $props();
</script>

<button
	class={cn(
		"bg-primary text-primary-foreground relative flex cursor-pointer items-center justify-center rounded-lg px-4 py-2 text-center",
		className
	)}
	style="--pulse-color: {pulseColor}; --duration: {duration};"
	{...props}
>
	<div class="relative z-10">
		{@render children()}
	</div>
	<div
		class="animate-pulse-ring absolute top-1/2 left-1/2 size-full -translate-x-1/2 -translate-y-1/2 rounded-lg bg-inherit"
	></div>
</button>
