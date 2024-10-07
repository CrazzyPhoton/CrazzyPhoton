# Escrow Smart Contract Project
**Created 3 escrow smart contracts, one for Ethereum(ETH), one for ERC721 NFTs and one for ERC20 tokens, smart contracts are compatible with EVM blockchains, this was a personal project.**
### [Ethereum Escrow](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Escrow%20Smart%20Contracts%20Project/Ethereum%20Escrow%20Smart%20Contract.sol)
**Deployed Ethereum Escrow smart contract on Goerli Testnet: https://goerli.etherscan.io/address/0x6eafbe9bc5b79d08b63c3575205d98cb0aa11a44#code**
### [NFT Escrow](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Escrow%20Smart%20Contracts%20Project/NFT%20Escrow%20Smart%20Contract.sol)
**Deployed NFT Escrow smart contract on Goerli Testnet: https://goerli.etherscan.io/address/0x13fe791c43c7cc54f23d24b9a64baf9d294b3391#code**
### [ERC20 Escrow](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Escrow%20Smart%20Contracts%20Project/ERC20%20Escrow%20Smart%20Contract.sol)
**Deployed ERC20 Escrow smart contract on Goerli Testnet: https://goerli.etherscan.io/address/0xdcc7663af840b376346e32b4e43befca4f7073d5#code**

*The **Ethereum, NFT, and ERC20** escrow smart contracts facilitate secure transactions between buyers and sellers by acting as intermediaries. The contracts manage the process through various states, such as creation, funding, delivery, and completion. They incorporate built-in functions to handle disputes, revisions, and cancellations, ensuring smooth and transparent interactions between parties. An arbiter plays a critical role in overseeing conflicts, fairly allocating funds to the buyer, seller, and themselves based on the resolution, while also managing fees.*

*The contracts log all actions through events like "EscrowCreated," "EscrowFunded," and "EscrowCompleted," providing an audit trail that enhances transparency. Flexible configurations, such as setting the escrow provider fee and automatic withdrawal time, allow the arbiter to adjust the system to specific needs. Additionally, mappings keep track of each party’s escrows, issues, and cancellation requests, offering users clear visibility of their active and completed transactions. These features work together to protect the interests of all involved parties while ensuring the security and reliability of the escrow process.*
