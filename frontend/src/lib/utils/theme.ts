export function initTheme() {
    const savedTheme = localStorage.getItem('theme');

    if (savedTheme === 'light' || savedTheme === 'dark') {
        document.documentElement.classList.toggle('dark', savedTheme === 'dark');
    } else {
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const nextTheme = prefersDark ? 'dark' : 'light';

        document.documentElement.classList.toggle('dark', nextTheme === 'dark');
        localStorage.setItem('theme', nextTheme);
    }
}

export function initDarkModeObserver(callback: (isDark: boolean) => void) {
    const updateDarkMode = () => {
        callback(document.documentElement.classList.contains('dark'));
    };

    updateDarkMode();

    const observer = new MutationObserver(updateDarkMode);
    observer.observe(document.documentElement, {
        attributes: true,
        attributeFilter: ['class']
    });

    return () => observer.disconnect();
}