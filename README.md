# BANFT Collection — ERC-721 NFT Collection

A fully deployed and verified ERC-721 NFT collection, built with Foundry and OpenZeppelin, live on **Arbitrum One** mainnet.

This project was built as part of the **Blockchain Accelerator** program, applying real-world deployment practices: IPFS-hosted metadata, on-chain verification, and L2 gas optimization.

## 🔗 Live Deployment

| | |
|---|---|
| **Network** | Arbitrum One (Chain ID: 42161) |
| **Contract Address** | [`0xbF9623F06c3c395Ec8df44104FC308e31Ab74A04`](https://arbiscan.io/address/0xbF9623F06c3c395Ec8df44104FC308e31Ab74A04) |
| **Status** | ✅ Verified on Arbiscan |
| **Standard** | ERC-721 |
| **Symbol** | BANFT |

Both tokens minted so far are visible and tradable on [OpenSea](https://opensea.io):

- **Token #0 — Pyroclaw Drake** (Fire Beast, Rare)
- **Token #1 — Tidebound Colossus** (Water Golem, Rare)

## 🃏 The Collection

Each NFT is a fully illustrated trading-card-style creature with on-chain-linked metadata: element, type, level, ATK/DEF stats, and rarity — all pulled from IPFS-hosted JSON via a custom `tokenURI` override.

**Pyroclaw Drake**
> A fire drake forged in the volcanic rifts of the realm. Every roar ignites the duel arena and melts the ice of rival cards.
> `Fire` · `Fire Beast` · Level 6 · ATK 2400 / DEF 1600 · Rare

**Tidebound Colossus**
> Sculpted from coral and abyssal stone, this sentinel guards the deep currents of the duel. Its glowing core extinguishes any rival flame.
> `Water` · `Water Golem` · Level 7 · ATK 1900 / DEF 2800 · Rare

## ⚙️ Technical Decisions

- **Sequential mint counter over user-chosen tokenId**: `mint()` takes no parameters and assigns the next available `currentTokenId` automatically, preventing double-minting and keeping supply strictly bounded by `totalSupply`.
- **Custom `_baseURI()` override**: points to a Pinata-pinned IPFS folder, decoupling on-chain logic from off-chain metadata storage — the standard pattern for scalable NFT collections.
- **`tokenURI()` reconstruction via OpenZeppelin's `Strings` library**: concatenates `baseURI + tokenId + ".json"` on the fly instead of storing per-token strings, saving storage gas at mint time.
- **`_requireOwned()` guard**: reverts `tokenURI()` calls for non-existent tokens, avoiding silent failures or misleading metadata responses.
- **Deployed on Arbitrum One (L2) instead of Ethereum mainnet**: full deploy + verification cost **~0.00004 ETH** (~$0.03 at the time of deploy) vs. what would be several dollars on L1 — same security guarantees, a fraction of the cost.

## 🛠️ Tech Stack

- **Solidity** `0.8.24`
- **Foundry** (Forge for build/deploy, Cast for wallet verification)
- **OpenZeppelin Contracts** v5.x (`ERC721`, `Strings`)
- **Pinata / IPFS** for decentralized image + metadata hosting
- **Arbitrum One** as the deployment network
- **Arbiscan** for contract verification

## 📦 Project Structure

```
NFT-COLLECTION/
├── src/
│   └── BANFTCollection.sol       # Main ERC-721 contract
├── script/
│   └── DeployNFTCollection.s.sol # Foundry deploy script
├── uris/
│   ├── 0.json                    # Pyroclaw Drake metadata
│   └── 1.json                    # Tidebound Colossus metadata
├── foundry.toml
└── remappings.txt
```

## 🚀 Running Locally

```bash
# Clone and install dependencies
git clone https://github.com/alchzamb/nft-collection.git
cd nft-collection
forge install

# Build
forge build

# Deploy (requires PRIVATE_KEY and ETHERSCAN_API_KEY in .env)
forge script script/DeployNFTCollection.s.sol \
  --rpc-url https://arb1.arbitrum.io/rpc \
  --broadcast \
  --verify
```

> ⚠️ Never commit your `.env` file. `PRIVATE_KEY` and `ETHERSCAN_API_KEY` must stay local — `.gitignore` is already configured to exclude it.

## 🧭 Next Steps

- [ ] Add Foundry test suite (mint flow, sold-out revert, tokenURI correctness)
- [ ] Add a public-facing mint page (front-end)
- [ ] Consider a supply-capped or paid public mint mechanism for future collections

## 👤 Author

**Alex** — Electronics & Telecommunications Engineer, transitioning into Smart Contract Development.
Built as part of the **Blockchain Accelerator** program (instructor: Jose Cruz).

[GitHub](https://github.com/alchzamb) · [LinkedIn](https://www.linkedin.com/in/alexzambrano-web3/)