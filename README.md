<h1 align ="center">Rahul Mayekar</h1>

***Freelance Smart Contract Developer for the past 2+ years. Have worked on 50+ blockchain projects for clients from US, Europe, Asia and Australia.***

***Freelance Profiles: [Fiverr](https://www.fiverr.com/rahulmayekar285?public_mode=true) & [Upwork](https://www.upwork.com/freelancers/~01ded178c72bac9434?viewMode=1)***

***Email: mayekarrahul26@gmail.com***

***Below is my portfolio as a smart contract developer.***

***Some of the custom smart contracts created by me for clients and personal projects.***

##
## CLIENT PROJECTS:-
## [1) Art Gallery Smart Contract Project](https://github.com/CrazzyPhoton/SmartContractProjects/tree/main/Smart%20Contracts%20For%20Art%20Gallery%20Project)
**Created 3 smart contracts for a client from France for their art gallery, the artwork is published as ERC1155 NFTs and the buying and selling process is handled by a marketplace type smart contract.**
### [Artist Profiler Gallery](https://github.com/CrazzyPhoton/SmartContractProjects/blob/main/Smart%20Contracts%20For%20Art%20Gallery%20Project/Artist%20Profiler%20Gallery.sol)
**Deployed smart contract on Polygon Amoy Testnet: https://www.oklink.com/amoy/address/0xefa55d4242ab6b3b8efb6387b460e90997a4746e/contract**

*The **Artist Profiler Gallery** smart contract releases annual art gallery editions as ERC1155 NFT tokens. It uses custom logic for managing both current and past editions and includes functionality for buying, selling, and handling royalties.*

### [Portraits](https://github.com/CrazzyPhoton/SmartContractProjects/blob/main/Smart%20Contracts%20For%20Art%20Gallery%20Project/Portraits.sol)
**Deployed smart contract on Polygon Amoy Testnet: https://www.oklink.com/amoy/address/0xc708ee1beddd3f74339923852ac05648dee7c304/contract**

*The **Portraits** smart contract releases annual artist portraits as ERC1155 NFTs. It features logic for managing portraits of collaborating artists and supports handling previous portrait editions.*

### [Buy And Sell](https://github.com/CrazzyPhoton/SmartContractProjects/blob/main/Smart%20Contracts%20For%20Art%20Gallery%20Project/BuyAndSell.sol)
**Deployed smart contract on Polygon Amoy Testnet: https://www.oklink.com/amoy/address/0x78fc67690219a8ebdba512a84822394dbd0b5137/contract**

*The **Buy and Sell** smart contract facilitates listing, buying, and canceling token sales of the **Portraits** smart contract, controlled by the owner. Sellers list tokens, set prices, and buyers purchase by paying the price plus royalties. The contract manages listings, royalty distribution, and emits events for sales and cancellations.*

##
## [2) Account Bound Token Smart Contract Project](https://github.com/CrazzyPhoton/CrazzyPhoton/tree/main/Account%20Bound%20Tokens%20Smart%20Contract%20Project)
**Created this smart contract for a client from Spain, the smart contract was for minting digital certificates as ERC721 account bound NFTs.**
### [MASTERWEB3](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Account%20Bound%20Tokens%20Smart%20Contract%20Project/MASTERWEB3.sol)
**Deployed smart contract on Polygon Amoy Testnet: https://www.oklink.com/amoy/address/0xad800dbd529de66d6a2efa1a5fb0d99edbc1dde0/contract**

*The **MASTERWEB3** smart contract is designed to issue and manage digital certificates as ERC721 non-transferable account bound NFTs for students who have completed the Master Web3 course. It enables the course provider to mint new certificates and securely transfer them to students' wallets. The contract incorporates security measures to prevent unauthorized transfers and tracks the total number of minted and burned certificates. Students can view their certificates using a central metadata URL, and the course provider can update this URL to refresh the certificate details for the entire collection. Additionally, the contract allows for verification of student ownership of certificates based on their wallet addresses.*

##
## [3) ERC721 Upgradeable Smart Contract Project](https://github.com/CrazzyPhoton/CrazzyPhoton/tree/main/ERC721%20Upgradeable%20Smart%20Contract%20Project)
**Created a upgradeable ERC721 smart contract for a client from USA for their NFT Project.**
### [Lucky Elephant Club](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/ERC721%20Upgradeable%20Smart%20Contract%20Project/Lucky%20Elephant%20Club.sol)
*The **Lucky Elephant Club** smart contract utilizes ERC721AUpgradeable for efficient NFT minting by inheriting from the ERC721A standard. Implemented Initializable, UUPSUpgradeable, and other OpenZeppelin upgradeable patterns, enabling upgrades without redeployment. Implemented a client requested feature which allows the ability to amalgamate NFTs into new ones using either one or two parent NFTs, and the integration of ERC20 tokens for this process. Used the merkle proof library of OpenZeppelin for implementing a gas efficient whitelist minting feature.*

##
## PERSONAL PROJECTS:-
## [1) Escrow Smart Contract Project](https://github.com/CrazzyPhoton/CrazzyPhoton/tree/main/Escrow%20Smart%20Contracts%20Project)
**Created 3 escrow smart contracts, one for Ethereum(ETH), one for ERC721 NFTs and one for ERC20 tokens, smart contracts are compatible with EVM blockchains, this was a personal project.**
### [Ethereum Escrow](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Escrow%20Smart%20Contracts%20Project/Ethereum%20Escrow%20Smart%20Contract.sol)
### [NFT Escrow](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Escrow%20Smart%20Contracts%20Project/NFT%20Escrow%20Smart%20Contract.sol)
### [ERC20 Escrow](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Escrow%20Smart%20Contracts%20Project/ERC20%20Escrow%20Smart%20Contract.sol)

*The **Ethereum, NFT, and ERC20** escrow smart contracts facilitate secure transactions between buyers and sellers by acting as intermediaries. The contracts manage the process through various states, such as creation, funding, delivery, and completion. They incorporate built-in functions to handle disputes, revisions, and cancellations, ensuring smooth and transparent interactions between parties. An arbiter plays a critical role in overseeing conflicts, fairly allocating funds to the buyer, seller, and themselves based on the resolution, while also managing fees.*

*The contracts log all actions through events like "EscrowCreated," "EscrowFunded," and "EscrowCompleted," providing an audit trail that enhances transparency. Flexible configurations, such as setting the escrow provider fee and automatic withdrawal time, allow the arbiter to adjust the system to specific needs. Additionally, mappings keep track of each party’s escrows, issues, and cancellation requests, offering users clear visibility of their active and completed transactions. These features work together to protect the interests of all involved parties while ensuring the security and reliability of the escrow process.*

##
## [2) Smart Contract Wallet Project](https://github.com/CrazzyPhoton/CrazzyPhoton/tree/main/Smart%20Contract%20Wallet%20Project)
**Created a smart contract which acts a wallet for cryptocurrency and NFTs compatible with EVM, this was a personal project.**
### [Smart Contract Wallet](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/Smart%20Contract%20Wallet%20Project/Smart%20Contract%20Wallet.sol)
*The **Smart Contract Wallet** serves as a digital safe for storing and managing various cryptocurrencies on the Ethereum and EVM compatible blockchains. It allows the owner to securely deposit and withdraw Ethereum (ETH) and other tokens like ERC20, ERC721, and ERC1155. The contract incorporates safeguards to prevent unauthorized access and ensures that the owner has sufficient funds before making transactions.*
