export function timeAgo(timestamp: number) {
    const diff = Math.floor((Date.now() - timestamp) / 1000);

    if (diff < 5) return 'just now';
    if (diff < 60) return `${diff} sec ago`;

    const minutes = Math.floor(diff / 60);
    if (minutes === 1) return '1 min ago';
    if (minutes < 60) return `${minutes} min ago`;

    const hours = Math.floor(minutes / 60);
    if (hours === 1) return 'last hour';
    if (hours < 24) return `${hours} hours ago`;

    const days = Math.floor(hours / 24);
    if (days === 1) return 'yesterday';
    if (days < 30) return `${days} days ago`;

    const months = Math.floor(days / 30);
    if (months === 1) return 'last month';
    if (months < 12) return `${months} months ago`;

    const years = Math.floor(months / 12);
    if (years === 1) return 'last year';

    return `${years} years ago`;
}