import { onMount } from 'svelte';
import { initDarkModeObserver } from '$lib/utils/theme';

export const theme = $state({
    isDark: false,
    accentColor: 'oklch(0.3 0 0)',
    beamColorFrom: '#3b3b3b',
    beamColorTo: '#3b3b3b',
    dotColor: 'rgba(59, 59, 59, 0.5)',
    gradientFrom: '#000000',
    gradientTo: '#333333',
    gradientOpacity: 0.1
});

export function initTheme() {
    onMount(() => {
        return initDarkModeObserver((dark) => {
            theme.isDark = dark;
            theme.accentColor = dark ? 'oklch(0.8 0 0)' : 'oklch(0.3 0 0)';
            theme.beamColorFrom = dark ? '#ffffff' : '#3b3b3b';
            theme.beamColorTo = dark ? '#ffffff' : '#3b3b3b';
            theme.dotColor = dark
                ? 'rgba(255, 255, 255, 0.3)'
                : 'rgba(59, 59, 59, 0.2)';
            theme.gradientFrom = dark ? '#ffffff' : '#000000';
            theme.gradientTo = dark ? '#cccccc' : '#333333';
            theme.gradientOpacity = dark ? 0.7 : 0.1;
        });
    });
}