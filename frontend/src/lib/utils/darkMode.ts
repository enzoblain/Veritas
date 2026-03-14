export function initDarkModeObserver(callback: (isDark: boolean) => void) {
    const updateDarkMode = () => {
        callback(document.documentElement.classList.contains('dark'));
    };

    updateDarkMode();

    const observer = new MutationObserver(updateDarkMode);
    observer.observe(document.documentElement, { attributes: true, attributeFilter: ['class'] });

    return () => observer.disconnect();
}
