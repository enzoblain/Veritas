export interface PricePoint {
    timestamp: number;
    amount: number;
    actor: string;
    role: 'producer' | 'distributor' | 'retailer';
    margin?: number;
}

export interface SupplyChainActor {
    id: string;
    name: string;
    role: 'producer' | 'distributor' | 'retailer';
    location: string;
    margin?: number;
}

export interface Product {
    id: string;
    name: string;
    description: string;
    category: string;
    image?: string;
    currentPrice: number;
    originalPrice: number;
    priceHistory: PricePoint[];
    supplyChain: SupplyChainActor[];
    createdAt: number;
    lastUpdated: number;
    isVerified: boolean;
}
