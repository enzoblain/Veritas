type HomeSearchBindings = {
    getInput: () => HTMLInputElement | null;
    getValue: () => string;
    setValue: (value: string) => void;
};

function focusSearchInput(input: HTMLInputElement | null, selectText = true): void {
    if (!input) return;

    input.focus();

    if (selectText) {
        input.select();
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

function isTypeToSearchKey(event: KeyboardEvent): boolean {
    return event.key.length === 1 && !event.ctrlKey && !event.metaKey && !event.altKey;
}

export function attachHomeSearchShortcuts(bindings: HomeSearchBindings): () => void {
    const onFocusSearch = () => {
        focusSearchInput(bindings.getInput());
    };

    const onTypeToSearch = (event: KeyboardEvent) => {
        if (!isTypeToSearchKey(event) || isEditableElement(event.target)) return;

        const input = bindings.getInput();

        if (!input) return;

        event.preventDefault();

        const nextValue = `${bindings.getValue()}${event.key}`;

        bindings.setValue(nextValue);
        focusSearchInput(input, false);
        input.setSelectionRange(nextValue.length, nextValue.length);
    };

    window.addEventListener('veritas:focus-search', onFocusSearch);
    window.addEventListener('keydown', onTypeToSearch);

    return () => {
        window.removeEventListener('veritas:focus-search', onFocusSearch);
        window.removeEventListener('keydown', onTypeToSearch);
    };
}