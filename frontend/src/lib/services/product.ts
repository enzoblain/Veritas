import type { Product } from '$lib/types/product';

export async function getProduct(id: string): Promise<Product | null> {
    await new Promise(resolve => setTimeout(resolve, 5000));

    return null;
}
export function getMockProduct(): Product {
    const mockProduct: Product = {
        id: "VRT-2024-CARROT",
        name: 'Smart Bottle',
        description: 'An intelligent water bottle that tracks your hydration levels.',
        category: 'Electronics',
        image: undefined,
        currentPrice: 49.99,
        originalPrice: 29.99,
        priceHistory: [
            { timestamp: Date.now() - 30 * 24 * 60 * 60 * 1000, amount: 29.99, actor: 'TechFlow Industries', role: 'producer', margin: 0 },
            { timestamp: Date.now() - 20 * 24 * 60 * 60 * 1000, amount: 37.99, actor: 'Global Distribution Co', role: 'distributor', margin: 8 },
            { timestamp: Date.now() - 10 * 24 * 60 * 60 * 1000, amount: 44.99, actor: 'ElectroMart', role: 'retailer', margin: 7 },
            { timestamp: Date.now(), amount: 49.99, actor: 'ElectroMart', role: 'retailer', margin: 5 }
        ],
        supplyChain: [
            { id: 'prod-001', name: 'TechFlow Industries', role: 'producer', location: 'Taiwan', margin: 15 },
            { id: 'dist-001', name: 'Global Distribution Co', role: 'distributor', location: 'Singapore', margin: 12 },
            { id: 'retail-001', name: 'ElectroMart', role: 'retailer', location: 'United States', margin: 20 }
        ],
        createdAt: Date.now() - 30 * 24 * 60 * 60 * 1000,
        lastUpdated: Date.now(),
        isVerified: true
    };

    return mockProduct;
}