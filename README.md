# Veritas

Veritas is a blockchain-based project that brings transparency to product pricing.

It allows the price of a product to be tracked and verified at every stage of its lifecycle — from producer to retailer. Each sale is recorded immutably on the blockchain, enabling consumers to see how a price evolved simply by scanning a QR code.

---

## Why Veritas?

Product prices are often opaque. Consumers rarely know how much a product cost at earlier stages or how margins evolved along the supply chain.

Veritas addresses this problem by using blockchain as a trust layer: once a price is recorded, it cannot be altered. This creates a transparent and verifiable pricing history that anyone can consult.

---

## ⚙️ How It Works

Veritas is built around three core components:

### ⛓️ On-chain smart contracts

Written in Plutus (Haskell), they enforce the rules of the system and store critical data such as prices, dates, and actors in an immutable way.

### 🖥️ Off-chain backend

Responsible for preparing transactions, interacting with the blockchain, and indexing on-chain data for fast access.

### 🌐 Frontend interface

A simple web interface that allows users to view a product’s full price history via a QR code.

The blockchain remains the single source of truth; off-chain components only improve usability and performance.

---

## 📦 Example Scenario

1. A producer registers a product on the blockchain. 
2. Each time the product is sold, the price and date are recorded.
3. In a store, a customer scans the product’s QR code. 
4. The interface displays the complete, verifiable price history.

---

## 🎯 Project Goals

- Explore a realistic blockchain use case
- Learn and apply functional programming with Haskell 
- Develop smart contracts using Plutus 
- Design a clean on-chain / off-chain architecture 
- Promote transparency and trust in pricing

---

## License

MIT
