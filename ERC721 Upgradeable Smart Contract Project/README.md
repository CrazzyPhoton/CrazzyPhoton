# ERC721 Upgradeable Smart Contract Project
**Created a upgradeable ERC721 smart contract for a client from USA for their NFT Project.**
### [Lucky Elephant Club](https://github.com/CrazzyPhoton/CrazzyPhoton/blob/main/ERC721%20Upgradeable%20Smart%20Contract%20Project/Lucky%20Elephant%20Club.sol)
**Deployed ERC1967 proxy smart contract on Ethereum Mainnet: https://etherscan.io/address/0x42de23cc51a8425c248c9801395dd47bd1996152#code**

**Deployed ERC721 implementation smart contract on Ethereum Mainnet: https://etherscan.io/address/0xe0fd07912b3b15453cfc02b59daf16d6e77a567d#code**

*The **Lucky Elephant Club** smart contract utilizes ERC721AUpgradeable for efficient NFT minting by inheriting from the ERC721A standard. Implemented Initializable, UUPSUpgradeable, and other OpenZeppelin upgradeable patterns, enabling upgrades without redeployment. Implemented a client requested feature which allows the ability to amalgamate NFTs into new ones using either one or two parent NFTs, and the integration of ERC20 tokens for this process. Used the merkle proof library of OpenZeppelin for implementing a gas efficient whitelist minting feature.*
