import { goto } from '$app/navigation';
import { tick } from 'svelte';

export type NavbarHistoryItem = {
    id: string;
    product: string;
    lastCheck: number;
};

type NavbarSearchBindings = {
    getInput: () => HTMLInputElement | null;
    getIsOpen: () => boolean;
    setIsOpen: (value: boolean) => void;
    getValue: () => string;
    setValue: (value: string) => void;
    getActiveHistoryIndex: () => number;
    setActiveHistoryIndex: (value: number) => void;
    getPreviewFilterQuery: () => string | null;
    setPreviewFilterQuery: (value: string | null) => void;
    getHistoryItems: () => NavbarHistoryItem[];
};

export const navbarLinks = [{ label: 'Home', href: '/' }];

export const navbarHistoryItems: NavbarHistoryItem[] = [
    { id: 'VRT-2026-00192', product: 'Smart Bottle', lastCheck: Date.now() - 2 * 60 * 1000 },
    { id: 'VRT-2026-00438', product: 'Travel Backpack', lastCheck: Date.now() - 15 * 60 * 1000 },
    { id: 'VRT-2026-00901', product: 'Coffee Grinder', lastCheck: Date.now() - 60 * 60 * 1000 },
    { id: 'VRT-2026-01077', product: 'Wireless Earbuds', lastCheck: Date.now() - 24 * 60 * 60 * 1000 },
    { id: 'VRT-2026-01104', product: 'Carbon Wallet', lastCheck: Date.now() - 24 * 60 * 60 * 1000 }
];

export function getFilteredNavbarHistory(
    historyItems: NavbarHistoryItem[],
    paletteId: string,
    previewFilterQuery: string | null
): NavbarHistoryItem[] {
    const query = (previewFilterQuery !== null ? previewFilterQuery : paletteId).trim().toLowerCase();

    if (!query) return historyItems;

    return historyItems.filter((item) => {
        return `${item.id} ${item.product}`.toLowerCase().includes(query);
    });
}

function resetPalette(bindings: NavbarSearchBindings): void {
    bindings.setValue('');
    bindings.setActiveHistoryIndex(-1);
    bindings.setPreviewFilterQuery(null);
}

export async function openNavbarPalette(bindings: NavbarSearchBindings): Promise<void> {
    resetPalette(bindings);
    bindings.setIsOpen(true);
    await tick();
    bindings.getInput()?.focus();
}

export function closeNavbarPalette(bindings: NavbarSearchBindings): void {
    bindings.setIsOpen(false);
    resetPalette(bindings);
}

export function submitNavbarPaletteSearch(bindings: NavbarSearchBindings): void {
    const id = bindings.getValue().trim();

    if (!id) return;

    goto(`/product/${id}`);
    closeNavbarPalette(bindings);
}

export function selectNavbarHistoryItem(
    bindings: NavbarSearchBindings,
    item: NavbarHistoryItem
): void {
    bindings.setValue(item.id);
    submitNavbarPaletteSearch(bindings);
}

export function moveNavbarHistorySelection(bindings: NavbarSearchBindings, step: number): void {
    const filteredHistory = getFilteredNavbarHistory(
        bindings.getHistoryItems(),
        bindings.getValue(),
        bindings.getPreviewFilterQuery()
    );

    if (!filteredHistory.length) return;

    if (bindings.getPreviewFilterQuery() === null) {
        bindings.setPreviewFilterQuery(bindings.getValue());
    }

    const activeHistoryIndex = bindings.getActiveHistoryIndex();
    const nextIndex = activeHistoryIndex < 0
        ? (step > 0 ? 0 : filteredHistory.length - 1)
        : (activeHistoryIndex + step + filteredHistory.length) % filteredHistory.length;

    bindings.setActiveHistoryIndex(nextIndex);
    bindings.setValue(filteredHistory[nextIndex].id);
}

export function resetNavbarHistoryPreview(bindings: NavbarSearchBindings): void {
    bindings.setActiveHistoryIndex(-1);
    bindings.setPreviewFilterQuery(null);
}

export function handleNavbarPaletteInputKeydown(
    event: KeyboardEvent,
    bindings: NavbarSearchBindings
): void {
    if (event.key === 'ArrowDown') {
        event.preventDefault();
        moveNavbarHistorySelection(bindings, 1);
        return;
    }

    if (event.key === 'ArrowUp') {
        event.preventDefault();
        moveNavbarHistorySelection(bindings, -1);
        return;
    }

    if (event.key === 'Enter') {
        event.preventDefault();

        const filteredHistory = getFilteredNavbarHistory(
            bindings.getHistoryItems(),
            bindings.getValue(),
            bindings.getPreviewFilterQuery()
        );
        const activeHistoryIndex = bindings.getActiveHistoryIndex();

        if (activeHistoryIndex >= 0 && filteredHistory[activeHistoryIndex]) {
            selectNavbarHistoryItem(bindings, filteredHistory[activeHistoryIndex]);
            return;
        }

        submitNavbarPaletteSearch(bindings);
    }
}

function isEditableElement(target: EventTarget | null): boolean {
    if (!(target instanceof HTMLElement)) return false;

    return (
        target instanceof HTMLInputElement ||
        target instanceof HTMLTextAreaElement ||
        target.isContentEditable
    );
}

export function attachNavbarPaletteShortcuts(bindings: NavbarSearchBindings): () => void {
    const onGlobalKeydown = (event: KeyboardEvent) => {
        if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'k') {
            event.preventDefault();

            if (bindings.getIsOpen()) {
                closeNavbarPalette(bindings);
            } else {
                void openNavbarPalette(bindings);
            }

            return;
        }

        if (event.key === 'Escape' && bindings.getIsOpen() && !isEditableElement(event.target)) {
            event.preventDefault();
            closeNavbarPalette(bindings);
        }
    };

    window.addEventListener('keydown', onGlobalKeydown);

    return () => {
        window.removeEventListener('keydown', onGlobalKeydown);
    };
}