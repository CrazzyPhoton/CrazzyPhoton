// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/utils/Context.sol

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/utils/Address.sol

// OpenZeppelin Contracts (last updated v4.8.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }
}

// File: @openzeppelin/contracts/utils/introspection/IERC165.sol

// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/interfaces/IERC2981.sol

// OpenZeppelin Contracts (last updated v4.6.0) (interfaces/IERC2981.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface for the NFT Royalty Standard.
 *
 * A standardized way to retrieve royalty payment information for non-fungible tokens (NFTs) to enable universal
 * support for royalty payments across all NFT marketplaces and ecosystem participants.
 *
 * _Available since v4.5._
 */
interface IERC2981 is IERC165 {
    /**
     * @dev Returns how much royalty is owed and to whom, based on a sale price that may be denominated in any unit of
     * exchange. The royalty amount is denominated and should be paid in that same unit of exchange.
     */
    function royaltyInfo(
        uint256 tokenId,
        uint256 salePrice
    ) external view returns (address receiver, uint256 royaltyAmount);
}

// File: @openzeppelin/contracts/utils/introspection/ERC165.sol

// OpenZeppelin Contracts v4.4.1 (utils/introspection/ERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 *
 * Alternatively, {ERC165Storage} provides an easier to use but more expensive implementation.
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

// File: @openzeppelin/contracts/token/common/ERC2981.sol

// OpenZeppelin Contracts (last updated v4.7.0) (token/common/ERC2981.sol)

pragma solidity ^0.8.0;

/**
 * @dev Implementation of the NFT Royalty Standard, a standardized way to retrieve royalty payment information.
 *
 * Royalty information can be specified globally for all token ids via {_setDefaultRoyalty}, and/or individually for
 * specific token ids via {_setTokenRoyalty}. The latter takes precedence over the first.
 *
 * Royalty is specified as a fraction of sale price. {_feeDenominator} is overridable but defaults to 10000, meaning the
 * fee is specified in basis points by default.
 *
 * IMPORTANT: ERC-2981 only specifies a way to signal royalty information and does not enforce its payment. See
 * https://eips.ethereum.org/EIPS/eip-2981#optional-royalty-payments[Rationale] in the EIP. Marketplaces are expected to
 * voluntarily pay royalties together with sales, but note that this standard is not yet widely supported.
 *
 * _Available since v4.5._
 */
abstract contract ERC2981 is IERC2981, ERC165 {
    struct RoyaltyInfo {
        address receiver;
        uint96 royaltyFraction;
    }

    RoyaltyInfo internal _defaultRoyaltyInfo;
    mapping(uint256 => RoyaltyInfo) private _tokenRoyaltyInfo;

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(IERC165, ERC165) returns (bool) {
        return
            interfaceId == type(IERC2981).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @inheritdoc IERC2981
     */
    function royaltyInfo(
        uint256 _tokenId,
        uint256 _salePrice
    ) public view virtual override returns (address, uint256) {
        RoyaltyInfo memory royalty = _tokenRoyaltyInfo[_tokenId];

        if (royalty.receiver == address(0)) {
            royalty = _defaultRoyaltyInfo;
        }

        uint256 royaltyAmount = (_salePrice * royalty.royaltyFraction) /
            _feeDenominator();

        return (royalty.receiver, royaltyAmount);
    }

    /**
     * @dev The denominator with which to interpret the fee set in {_setTokenRoyalty} and {_setDefaultRoyalty} as a
     * fraction of the sale price. Defaults to 10000 so fees are expressed in basis points, but may be customized by an
     * override.
     */
    function _feeDenominator() internal pure virtual returns (uint96) {
        return 10000;
    }

    /**
     * @dev Sets the royalty information that all ids in this contract will default to.
     *
     * Requirements:
     *
     * - `receiver` cannot be the zero address.
     * - `feeNumerator` cannot be greater than the fee denominator.
     */
    function _setDefaultRoyalty(
        address receiver,
        uint96 feeNumerator
    ) internal virtual {
        require(
            feeNumerator <= _feeDenominator(),
            "ERC2981: royalty fee will exceed salePrice"
        );
        require(receiver != address(0), "ERC2981: invalid receiver");

        _defaultRoyaltyInfo = RoyaltyInfo(receiver, feeNumerator);
    }

    /**
     * @dev Sets the royalty information for a specific token id, overriding the global default.
     *
     * Requirements:
     *
     * - `receiver` cannot be the zero address.
     * - `feeNumerator` cannot be greater than the fee denominator.
     */
    function _setTokenRoyalty(
        uint256 tokenId,
        address receiver,
        uint96 feeNumerator
    ) internal virtual {
        require(
            feeNumerator <= _feeDenominator(),
            "ERC2981: royalty fee will exceed salePrice"
        );
        require(receiver != address(0), "ERC2981: Invalid parameters");

        _tokenRoyaltyInfo[tokenId] = RoyaltyInfo(receiver, feeNumerator);
    }
}

// File: @openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol

// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC1155/IERC1155Receiver.sol)

pragma solidity ^0.8.0;

/**
 * @dev _Available since v3.1._
 */
interface IERC1155Receiver is IERC165 {
    /**
     * @dev Handles the receipt of a single ERC1155 token type. This function is
     * called at the end of a `safeTransferFrom` after the balance has been updated.
     *
     * NOTE: To accept the transfer, this must return
     * `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
     * (i.e. 0xf23a6e61, or its own function selector).
     *
     * @param operator The address which initiated the transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param id The ID of the token being transferred
     * @param value The amount of tokens being transferred
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
     */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev Handles the receipt of a multiple ERC1155 token types. This function
     * is called at the end of a `safeBatchTransferFrom` after the balances have
     * been updated.
     *
     * NOTE: To accept the transfer(s), this must return
     * `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
     * (i.e. 0xbc197c81, or its own function selector).
     *
     * @param operator The address which initiated the batch transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param ids An array containing ids of each token being transferred (order and length must match values array)
     * @param values An array containing amounts of each token being transferred (order and length must match ids array)
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` if transfer is allowed
     */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}

// File: @openzeppelin/contracts/token/ERC1155/IERC1155.sol

// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC1155/IERC1155.sol)

pragma solidity ^0.8.0;

/**
 * @dev Required interface of an ERC1155 compliant contract, as defined in the
 * https://eips.ethereum.org/EIPS/eip-1155[EIP].
 *
 * _Available since v3.1._
 */
interface IERC1155 is IERC165 {
    /**
     * @dev Emitted when `value` tokens of token type `id` are transferred from `from` to `to` by `operator`.
     */
    event TransferSingle(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256 id,
        uint256 value
    );

    /**
     * @dev Equivalent to multiple {TransferSingle} events, where `operator`, `from` and `to` are the same for all
     * transfers.
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(
        address indexed account,
        address indexed operator,
        bool approved
    );

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     *
     * If an {URI} event was emitted for `id`, the standard
     * https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[guarantees] that `value` will equal the value
     * returned by {IERC1155MetadataURI-uri}.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(
        address account,
        uint256 id
    ) external view returns (uint256);

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {balanceOf}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(
        address[] calldata accounts,
        uint256[] calldata ids
    ) external view returns (uint256[] memory);

    /**
     * @dev Grants or revokes permission to `operator` to transfer the caller's tokens, according to `approved`,
     *
     * Emits an {ApprovalForAll} event.
     *
     * Requirements:
     *
     * - `operator` cannot be the caller.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns true if `operator` is approved to transfer ``account``'s tokens.
     *
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(
        address account,
        address operator
    ) external view returns (bool);

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}

// File: @openzeppelin/contracts/token/ERC1155/extensions/IERC1155MetadataURI.sol

// OpenZeppelin Contracts v4.4.1 (token/ERC1155/extensions/IERC1155MetadataURI.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the optional ERC1155MetadataExtension interface, as defined
 * in the https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[EIP].
 *
 * _Available since v3.1._
 */
interface IERC1155MetadataURI is IERC1155 {
    /**
     * @dev Returns the URI for token type `id`.
     *
     * If the `\{id\}` substring is present in the URI, it must be replaced by
     * clients with the actual token type ID.
     */
    function uri(uint256 id) external view returns (string memory);
}

// File: @openzeppelin/contracts/token/ERC1155/ERC1155.sol

// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC1155/ERC1155.sol)

pragma solidity ^0.8.0;

/**
 * @dev Implementation of the basic standard multi-token.
 * See https://eips.ethereum.org/EIPS/eip-1155
 * Originally based on code by Enjin: https://github.com/enjin/erc-1155
 *
 * _Available since v3.1._
 */
contract ERC1155 is Context, ERC165, IERC1155, IERC1155MetadataURI {
    using Address for address;

    // Mapping from token ID to account balances
    mapping(uint256 => mapping(address => uint256)) private _balances;

    // Mapping from account to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // Used as the URI for all token types by relying on ID substitution, e.g. https://token-cdn-domain/{id}.json
    string private _uri;

    /**
     * @dev See {_setURI}.
     */
    constructor(string memory uri_) {
        _setURI(uri_);
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC1155).interfaceId ||
            interfaceId == type(IERC1155MetadataURI).interfaceId ||
            super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC1155MetadataURI-uri}.
     *
     * This implementation returns the same URI for *all* token types. It relies
     * on the token type ID substitution mechanism
     * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
     *
     * Clients calling this function must replace the `\{id\}` substring with the
     * actual token type ID.
     */
    function uri(uint256) public view virtual override returns (string memory) {
        return _uri;
    }

    /**
     * @dev See {IERC1155-balanceOf}.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(
        address account,
        uint256 id
    ) public view virtual override returns (uint256) {
        require(
            account != address(0),
            "ERC1155: address zero is not a valid owner"
        );
        return _balances[id][account];
    }

    /**
     * @dev See {IERC1155-balanceOfBatch}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(
        address[] memory accounts,
        uint256[] memory ids
    ) public view virtual override returns (uint256[] memory) {
        require(
            accounts.length == ids.length,
            "ERC1155: accounts and ids length mismatch"
        );

        uint256[] memory batchBalances = new uint256[](accounts.length);

        for (uint256 i = 0; i < accounts.length; ++i) {
            batchBalances[i] = balanceOf(accounts[i], ids[i]);
        }

        return batchBalances;
    }

    /**
     * @dev See {IERC1155-setApprovalForAll}.
     */
    function setApprovalForAll(
        address operator,
        bool approved
    ) public virtual override {
        _setApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC1155-isApprovedForAll}.
     */
    function isApprovedForAll(
        address account,
        address operator
    ) public view virtual override returns (bool) {
        return _operatorApprovals[account][operator];
    }

    /**
     * @dev See {IERC1155-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            from == _msgSender() || isApprovedForAll(from, _msgSender()),
            "ERC1155: caller is not token owner or approved"
        );
        _safeTransferFrom(from, to, id, amount, data);
    }

    /**
     * @dev See {IERC1155-safeBatchTransferFrom}.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        require(
            from == _msgSender() || isApprovedForAll(from, _msgSender()),
            "ERC1155: caller is not token owner or approved"
        );
        _safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function _safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: transfer to the zero address");

        address operator = _msgSender();
        uint256[] memory ids = _asSingletonArray(id);
        uint256[] memory amounts = _asSingletonArray(amount);

        _beforeTokenTransfer(operator, from, to, ids, amounts, data);

        uint256 fromBalance = _balances[id][from];
        require(
            fromBalance >= amount,
            "ERC1155: insufficient balance for transfer"
        );
        unchecked {
            _balances[id][from] = fromBalance - amount;
        }
        _balances[id][to] += amount;

        emit TransferSingle(operator, from, to, id, amount);

        _afterTokenTransfer(operator, from, to, ids, amounts, data);

        _doSafeTransferAcceptanceCheck(operator, from, to, id, amount, data);
    }

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function _safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {
        require(
            ids.length == amounts.length,
            "ERC1155: ids and amounts length mismatch"
        );
        require(to != address(0), "ERC1155: transfer to the zero address");

        address operator = _msgSender();

        _beforeTokenTransfer(operator, from, to, ids, amounts, data);

        for (uint256 i = 0; i < ids.length; ++i) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(
                fromBalance >= amount,
                "ERC1155: insufficient balance for transfer"
            );
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
            _balances[id][to] += amount;
        }

        emit TransferBatch(operator, from, to, ids, amounts);

        _afterTokenTransfer(operator, from, to, ids, amounts, data);

        _doSafeBatchTransferAcceptanceCheck(
            operator,
            from,
            to,
            ids,
            amounts,
            data
        );
    }

    /**
     * @dev Sets a new URI for all token types, by relying on the token type ID
     * substitution mechanism
     * https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].
     *
     * By this mechanism, any occurrence of the `\{id\}` substring in either the
     * URI or any of the amounts in the JSON file at said URI will be replaced by
     * clients with the token type ID.
     *
     * For example, the `https://token-cdn-domain/\{id\}.json` URI would be
     * interpreted by clients as
     * `https://token-cdn-domain/000000000000000000000000000000000000000000000000000000000004cce0.json`
     * for token type ID 0x4cce0.
     *
     * See {uri}.
     *
     * Because these URIs cannot be meaningfully represented by the {URI} event,
     * this function emits no events.
     */
    function _setURI(string memory newuri) internal virtual {
        _uri = newuri;
    }

    /**
     * @dev Creates `amount` tokens of token type `id`, and assigns them to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function _mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) internal virtual {
        require(to != address(0), "ERC1155: mint to the zero address");

        address operator = _msgSender();
        uint256[] memory ids = _asSingletonArray(id);
        uint256[] memory amounts = _asSingletonArray(amount);

        _beforeTokenTransfer(operator, address(0), to, ids, amounts, data);

        _balances[id][to] += amount;
        emit TransferSingle(operator, address(0), to, id, amount);

        _afterTokenTransfer(operator, address(0), to, ids, amounts, data);

        _doSafeTransferAcceptanceCheck(
            operator,
            address(0),
            to,
            id,
            amount,
            data
        );
    }

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_burn}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     */
    function _burnBatch(
        address from,
        uint256[] memory ids,
        uint256[] memory amounts
    ) internal virtual {
        require(from != address(0), "ERC1155: burn from the zero address");
        require(
            ids.length == amounts.length,
            "ERC1155: ids and amounts length mismatch"
        );

        address operator = _msgSender();

        _beforeTokenTransfer(operator, from, address(0), ids, amounts, "");

        for (uint256 i = 0; i < ids.length; i++) {
            uint256 id = ids[i];
            uint256 amount = amounts[i];

            uint256 fromBalance = _balances[id][from];
            require(
                fromBalance >= amount,
                "ERC1155: burn amount exceeds balance"
            );
            unchecked {
                _balances[id][from] = fromBalance - amount;
            }
        }

        emit TransferBatch(operator, from, address(0), ids, amounts);

        _afterTokenTransfer(operator, from, address(0), ids, amounts, "");
    }

    /**
     * @dev Approve `operator` to operate on all of `owner` tokens
     *
     * Emits an {ApprovalForAll} event.
     */
    function _setApprovalForAll(
        address owner,
        address operator,
        bool approved
    ) internal virtual {
        require(owner != operator, "ERC1155: setting approval status for self");
        _operatorApprovals[owner][operator] = approved;
        emit ApprovalForAll(owner, operator, approved);
    }

    /**
     * @dev Hook that is called before any token transfer. This includes minting
     * and burning, as well as batched variants.
     *
     * The same hook is called on both single and batched variants. For single
     * transfers, the length of the `ids` and `amounts` arrays will be 1.
     *
     * Calling conditions (for each `id` and `amount` pair):
     *
     * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * of token type `id` will be  transferred to `to`.
     * - When `from` is zero, `amount` tokens of token type `id` will be minted
     * for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
     * will be burned.
     * - `from` and `to` are never both zero.
     * - `ids` and `amounts` have the same, non-zero length.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {}

    /**
     * @dev Hook that is called after any token transfer. This includes minting
     * and burning, as well as batched variants.
     *
     * The same hook is called on both single and batched variants. For single
     * transfers, the length of the `id` and `amount` arrays will be 1.
     *
     * Calling conditions (for each `id` and `amount` pair):
     *
     * - When `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * of token type `id` will be  transferred to `to`.
     * - When `from` is zero, `amount` tokens of token type `id` will be minted
     * for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens of token type `id`
     * will be burned.
     * - `from` and `to` are never both zero.
     * - `ids` and `amounts` have the same, non-zero length.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual {}

    function _doSafeTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try
                IERC1155Receiver(to).onERC1155Received(
                    operator,
                    from,
                    id,
                    amount,
                    data
                )
            returns (bytes4 response) {
                if (response != IERC1155Receiver.onERC1155Received.selector) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155Receiver implementer");
            }
        }
    }

    function _doSafeBatchTransferAcceptanceCheck(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) private {
        if (to.isContract()) {
            try
                IERC1155Receiver(to).onERC1155BatchReceived(
                    operator,
                    from,
                    ids,
                    amounts,
                    data
                )
            returns (bytes4 response) {
                if (
                    response != IERC1155Receiver.onERC1155BatchReceived.selector
                ) {
                    revert("ERC1155: ERC1155Receiver rejected tokens");
                }
            } catch Error(string memory reason) {
                revert(reason);
            } catch {
                revert("ERC1155: transfer to non-ERC1155Receiver implementer");
            }
        }
    }

    function _asSingletonArray(
        uint256 element
    ) private pure returns (uint256[] memory) {
        uint256[] memory array = new uint256[](1);
        array[0] = element;

        return array;
    }
}

// File: @openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol

// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC1155/extensions/ERC1155Supply.sol)

pragma solidity ^0.8.0;

/**
 * @dev Extension of ERC1155 that adds tracking of total supply per id.
 *
 * Useful for scenarios where Fungible and Non-fungible tokens have to be
 * clearly identified. Note: While a totalSupply of 1 might mean the
 * corresponding is an NFT, there is no guarantees that no other token with the
 * same id are not going to be minted.
 */
abstract contract ERC1155Supply is ERC1155 {
    mapping(uint256 => uint256) private _totalSupply;

    /**
     * @dev Total amount of tokens in with a given id.
     */
    function totalSupply(uint256 id) public view virtual returns (uint256) {
        return _totalSupply[id];
    }

    /**
     * @dev Indicates whether any token exist with a given id, or not.
     */
    function exists(uint256 id) public view virtual returns (bool) {
        return ERC1155Supply.totalSupply(id) > 0;
    }

    /**
     * @dev See {ERC1155-_beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal virtual override {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);

        if (from == address(0)) {
            for (uint256 i = 0; i < ids.length; ++i) {
                _totalSupply[ids[i]] += amounts[i];
            }
        }

        if (to == address(0)) {
            for (uint256 i = 0; i < ids.length; ++i) {
                uint256 id = ids[i];
                uint256 amount = amounts[i];
                uint256 supply = _totalSupply[id];
                require(
                    supply >= amount,
                    "ERC1155: burn amount exceeds totalSupply"
                );
                unchecked {
                    _totalSupply[id] = supply - amount;
                }
            }
        }
    }
}

// File: @openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol

// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC1155/extensions/ERC1155Burnable.sol)

pragma solidity ^0.8.0;

/**
 * @dev Extension of {ERC1155} that allows token holders to destroy both their
 * own tokens and those that they have been approved to use.
 *
 * _Available since v3.1._
 */
abstract contract ERC1155Burnable is ERC1155 {
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values
    ) internal virtual {
        require(
            account == _msgSender() || isApprovedForAll(account, _msgSender()),
            "ERC1155: caller is not token owner or approved"
        );

        _burnBatch(account, ids, values);
    }
}

// File: contracts/Portraits.sol

pragma solidity ^0.8.24;

contract Portraits is
    ERC1155,
    Ownable,
    ERC1155Burnable,
    ERC1155Supply,
    ERC2981
{
    // STATE VARIABLES //

    /// @notice Addresses array to store allowed operators.
    address[] private allowedOperators;

    /// @notice Address of the gallery contract.
    address public galleryContract;

    /// @notice Address of the museum.
    address public museumAddress;

    /// @notice Boolean for enabling and all disabling operator transfers.
    bool public allowedAllOperatorTransfer;

    /// @notice Boolean for permanently disabling burning function.
    bool public burnStatus = true;

    /// @notice Boolean to enable and disable artist minting.
    bool public artistMinting;

    /// @notice Mapping for checking whether operator is added.
    mapping(address => bool) public isOperatorAdded;

    /// @notice Mapping for checking whether portrait is added.
    mapping(string => bool) public isPortraitAdded;

    /// @notice Mapping for checking whether a version of portrait's edition type is minted.
    mapping(string => mapping(uint256 => bool))
        public isPortraitEditionTypeVersionMinted;

    /// @notice Mapping for storing portrait artist.
    mapping(string => address) private portraitArtist;

    /// @notice Mapping for storing portrait royalties.
    mapping(string => uint96) private portraitRoyalties;

    /// @notice Mapping for storing token info.
    mapping(uint256 => TokenInfo) private _tokenInfo;

    /// @notice Collection name.
    string private _name = "Portraits";

    /// @notice String array to store portraits.
    string[] private portraits;

    /// @notice Collection symbol.
    string private _symbol = "Portraits";

    /// @notice Struct for storing token info.
    struct TokenInfo {
        string portraitName;
        string editionType;
        uint256 editionAmount;
        uint256 editionVersion;
        string editionUri;
    }

    /// @notice The current year.
    uint256 public currentYear = 2024;

    /// @notice The max royalty basis points.
    uint96 public maxRoyalty = 1200;

    /// @notice The owner royalty basis points.
    uint96 private ownerRoyalties = 1200;

    /// @notice The total number of minted tokenIds.
    uint256 private _totalMinted;

    // CONSTRUCTOR //

    constructor() ERC1155("") {}

    // NAME & SYMBOL //

    /// @notice Return collection name.
    function name() public view returns (string memory) {
        return _name;
    }

    /// @notice Return collection symbol.
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    // MODIFIER //

    /// @notice Modifier which only allows owner, gallery contract or portrait artist to execute certain functions.
    modifier onlyOwnerOrGalleryContractOrArtist(string memory _portraitName) {
        require(
            (msg.sender == owner() ||
                msg.sender == galleryContract ||
                msg.sender == portraitArtist[_portraitName]) &&
                isPortraitAdded[_portraitName] == true,
            "Invalid caller or portrait not added"
        );
        _;
    }

    /// @notice Modifier to check whether portrait's artist can mint.
    modifier canArtistMint(string memory _portraitName) {
        if (
            msg.sender == portraitArtist[_portraitName] && msg.sender != owner()
        ) {
            require(artistMinting == true, "Artist minting not enabled");
        }
        _;
    }

    /// @notice Modifier which only allows owner and gallery contract to execute certain functions.
    modifier onlyOwnerOrGalleryContract() {
        require(
            msg.sender == owner() || msg.sender == galleryContract,
            "Invalid caller"
        );
        _;
    }

    // BURN FUNCTION //

    /**
     * @notice Smart contract owner only function.
     *         Functions burns entered edition amounts of entered tokenIds.
     *
     * @param _address        The wallet address.
     * @param tokenIds        The tokenIds array.
     * @param _editionAmounts The edition amounts array.
     */
    function burn(
        address _address,
        uint256[] calldata tokenIds,
        uint256[] calldata _editionAmounts
    ) public onlyOwner {
        require(burnStatus == true, "Burning permanently disabled");
        burnBatch(_address, tokenIds, _editionAmounts);
        for (uint256 i = 0; i < tokenIds.length; ++i) {
            _tokenInfo[tokenIds[i]].editionAmount -= _editionAmounts[i];
        }
    }

    // MINTING FUNCTION //

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints portrait's 2023 artist edition to the artist.
     *
     * @param _portraitName The portrait name.
     * @param _editionUri   The edition uri.
     */
    function mintArtistEdition2023(
        string memory _portraitName,
        string memory _editionUri
    ) public onlyOwnerOrGalleryContract {
        require(isPortraitAdded[_portraitName] == true, "Portrait not added");
        string memory combinedString = string.concat(
            _portraitName,
            "Artist Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][2023] == false,
            "2023 version for portrait's artist edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][2023] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted].portraitName = _portraitName;
        _tokenInfo[_totalMinted].editionType = "Artist Edition";
        _tokenInfo[_totalMinted].editionAmount = 1;
        _tokenInfo[_totalMinted].editionVersion = 2023;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        address _recipient = portraitArtist[_portraitName];
        _mint(_recipient, _totalMinted, 1, "");
    }

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints portrait's 2023 museum edition to the museum.
     *
     * @param _portraitName The portrait name.
     * @param _editionUri   The edition uri.
     */
    function mintMuseumEdition2023(
        string memory _portraitName,
        string memory _editionUri
    ) public onlyOwnerOrGalleryContract {
        require(isPortraitAdded[_portraitName] == true, "Portrait not added");
        string memory combinedString = string.concat(
            _portraitName,
            "Museum Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][2023] == false,
            "2023 version for portrait's museum edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][2023] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted].portraitName = _portraitName;
        _tokenInfo[_totalMinted].editionType = "Museum Edition";
        _tokenInfo[_totalMinted].editionAmount = 1;
        _tokenInfo[_totalMinted].editionVersion = 2023;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        address _recipient = museumAddress;
        _mint(_recipient, _totalMinted, 1, "");
    }

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints 2 commercial editions of Portrait du Prix Marcel Duchamp to the recipient.
     *
     * @param _recipient      The recipient wallet address.
     * @param _editionVersion The edition version.
     * @param _editionUri     The edition uri.
     */
    function mintCommercialEditionOfPortraitduPrixMarcelDuchamp(
        address _recipient,
        uint256 _editionVersion,
        string memory _editionUri
    )
        public
        onlyOwnerOrGalleryContractOrArtist("Portrait du Prix Marcel Duchamp")
        canArtistMint("Portrait du Prix Marcel Duchamp")
    {
        string memory combinedString = string.concat(
            "Portrait du Prix Marcel Duchamp",
            "Commercial Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][
                _editionVersion
            ] == false,
            "Entered version for portrait's commercial edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][
            _editionVersion
        ] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted]
            .portraitName = "Portrait du Prix Marcel Duchamp";
        _tokenInfo[_totalMinted].editionType = "Commercial Edition";
        _tokenInfo[_totalMinted].editionAmount = 2;
        require(
            _editionVersion > 2023,
            "Edition version should be greater than 2023"
        );
        require(
            _editionVersion <= currentYear,
            "Can't mint next year version in current year"
        );
        _tokenInfo[_totalMinted].editionVersion = _editionVersion;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        _mint(_recipient, _totalMinted, 2, "");
    }

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints entered amount of individual portrait's commercial editions to the recipient.
     *
     * @param _recipient      The recipient wallet address.
     * @param _portraitName   The portrait name.
     * @param _editionAmount  The edition amount.
     * @param _editionVersion The edition version.
     * @param _editionUri     The edition uri.
     */
    function mintCommercialEditionForIndividualPortrait(
        address _recipient,
        string memory _portraitName,
        uint256 _editionAmount,
        uint256 _editionVersion,
        string memory _editionUri
    )
        public
        onlyOwnerOrGalleryContractOrArtist(_portraitName)
        canArtistMint(_portraitName)
    {
        require(
            keccak256(abi.encodePacked(_portraitName)) !=
                keccak256(abi.encodePacked("Portrait du Prix Marcel Duchamp")),
            "Can't mint Portrait du Prix Marcel Duchamp commercial editions using this function"
        );
        string memory combinedString = string.concat(
            _portraitName,
            "Commercial Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][
                _editionVersion
            ] == false,
            "Entered version for portrait's commercial edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][
            _editionVersion
        ] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted].portraitName = _portraitName;
        _tokenInfo[_totalMinted].editionType = "Commercial Edition";
        _tokenInfo[_totalMinted].editionAmount = _editionAmount;
        require(
            _editionVersion > 2023,
            "Edition version should be greater than 2023"
        );
        require(
            _editionVersion <= currentYear,
            "Can't mint next year version in current year"
        );
        _tokenInfo[_totalMinted].editionVersion = _editionVersion;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        _mint(_recipient, _totalMinted, _editionAmount, "");
    }

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints portrait's artist edition to the artist.
     *
     * @param _portraitName   The portrait name.
     * @param _editionVersion The edition version.
     * @param _editionUri     The edition uri.
     */
    function mintArtistEdition(
        string memory _portraitName,
        uint256 _editionVersion,
        string memory _editionUri
    )
        public
        onlyOwnerOrGalleryContractOrArtist(_portraitName)
        canArtistMint(_portraitName)
    {
        string memory combinedString = string.concat(
            _portraitName,
            "Artist Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][
                _editionVersion
            ] == false,
            "Entered version for portrait's artist edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][
            _editionVersion
        ] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted].portraitName = _portraitName;
        _tokenInfo[_totalMinted].editionType = "Artist Edition";
        _tokenInfo[_totalMinted].editionAmount = 1;
        require(
            _editionVersion > 2023,
            "Edition version should be greater than 2023"
        );
        require(
            _editionVersion <= currentYear,
            "Can't mint next year version in current year"
        );
        _tokenInfo[_totalMinted].editionVersion = _editionVersion;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        address _recipient = portraitArtist[_portraitName];
        _mint(_recipient, _totalMinted, 1, "");
    }

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints portrait's museum edition to the museum.
     *
     * @param _portraitName   The portrait name.
     * @param _editionVersion The edition version.
     * @param _editionUri     The edition uri.
     */
    function mintMuseumEdition(
        string memory _portraitName,
        uint256 _editionVersion,
        string memory _editionUri
    )
        public
        onlyOwnerOrGalleryContractOrArtist(_portraitName)
        canArtistMint(_portraitName)
    {
        string memory combinedString = string.concat(
            _portraitName,
            "Museum Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][
                _editionVersion
            ] == false,
            "Entered version for portrait's museum edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][
            _editionVersion
        ] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted].portraitName = _portraitName;
        _tokenInfo[_totalMinted].editionType = "Museum Edition";
        _tokenInfo[_totalMinted].editionAmount = 1;
        require(
            _editionVersion > 2023,
            "Edition version should be greater than 2023"
        );
        require(
            _editionVersion <= currentYear,
            "Can't mint next year version in current year"
        );
        _tokenInfo[_totalMinted].editionVersion = _editionVersion;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        address _recipient = museumAddress;
        _mint(_recipient, _totalMinted, 1, "");
    }

    /**
     * @notice Smart contract owner, gallery contract or portrait artist as caller only function.
     *         Function mints portrait's gallery edition to smart contract owner.
     *
     * @param _portraitName   The portrait name.
     * @param _editionVersion The edition version.
     * @param _editionUri     The edition uri.
     */
    function mintGalleryEdition(
        string memory _portraitName,
        uint256 _editionVersion,
        string memory _editionUri
    )
        public
        onlyOwnerOrGalleryContractOrArtist(_portraitName)
        canArtistMint(_portraitName)
    {
        string memory combinedString = string.concat(
            _portraitName,
            "Gallery Edition"
        );
        require(
            isPortraitEditionTypeVersionMinted[combinedString][
                _editionVersion
            ] == false,
            "Entered version for portrait's gallery edition minted"
        );
        isPortraitEditionTypeVersionMinted[combinedString][
            _editionVersion
        ] = true;
        ++_totalMinted;
        _tokenInfo[_totalMinted].portraitName = _portraitName;
        _tokenInfo[_totalMinted].editionType = "Gallery Edition";
        _tokenInfo[_totalMinted].editionAmount = 1;
        require(
            _editionVersion > 2023,
            "Edition version should be greater than 2023"
        );
        require(
            _editionVersion <= currentYear - 1,
            "Can't mint current year version in current year"
        );
        _tokenInfo[_totalMinted].editionVersion = _editionVersion;
        _tokenInfo[_totalMinted].editionUri = _editionUri;
        emit URI(_editionUri, _totalMinted);
        address _recipient = portraitArtist[_portraitName];
        _mint(_recipient, _totalMinted, 1, "");
    }

    // OTHER WRITE FUNCTIONS //

    /**
     * @notice Smart contract owner only function.
     *         Function sets the portrait's artist address.
     *
     * @param _portraitName  The name of the portriat.
     * @param _portraitArtist The address of the portrait artist.
     */
    function setArtistAddress(
        string memory _portraitName,
        address _portraitArtist
    ) public onlyOwner {
        require(isPortraitAdded[_portraitName] == true, "Portrait not added");
        require(
            _portraitArtist != address(0),
            "Address can't be the zero address"
        );
        portraitArtist[_portraitName] = _portraitArtist;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function sets the gallery contract address.
     *
     * @param _galleryContract The address of the gallery contract.
     */
    function setGalleryContract(address _galleryContract) public onlyOwner {
        require(
            _galleryContract != address(0),
            "Address can't be the zero address"
        );
        galleryContract = _galleryContract;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function sets the museum address.
     *
     * @param _museumAddress The address of the museum.
     */
    function setMuseumAddress(address _museumAddress) public onlyOwner {
        require(
            _museumAddress != address(0),
            "Address can't be the zero address"
        );
        museumAddress = _museumAddress;
    }

    /**
     * @notice Smart contract owner only and gallery contract as caller only function.
     *         Function sets the current year.
     *
     * @param _currentYear The current year.
     */
    function setCurrentYear(
        uint256 _currentYear
    ) public onlyOwnerOrGalleryContract {
        currentYear = _currentYear;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function sets tokenId edition version.
     *
     * @param tokenId         The tokenId.
     * @param _editionVersion The edition version.
     */
    function setTokenEditionVersion(
        uint256 tokenId,
        uint256 _editionVersion
    ) public onlyOwner {
        require(
            tokenId >= 1 && tokenId <= _totalMinted,
            "tokenId not yet minted"
        );
        _tokenInfo[tokenId].editionVersion = _editionVersion;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function sets tokenId edition uri.
     *
     * @param tokenId     The tokenId.
     * @param _editionUri The edition uri.
     */
    function setTokenEditionUri(
        uint256 tokenId,
        string memory _editionUri
    ) public onlyOwner {
        require(
            tokenId >= 1 && tokenId <= _totalMinted,
            "tokenId not yet minted"
        );
        _tokenInfo[tokenId].editionUri = _editionUri;
        emit URI(_editionUri, tokenId);
    }

    /**
     * @notice Smart contract owner only function
     *         Permanently disables burn function.
     *
     * @param state The state value must be: false.
     */
    function permanentlyDisableBurn(bool state) public onlyOwner {
        require(state == false, "State must be false");
        burnStatus = state;
    }

    /**
     * @notice Smart contract owner only function
     *         Enables and disables all operator transfers.
     */
    function toggleAllowedAllOperatorTransfer() public onlyOwner {
        allowedAllOperatorTransfer = !allowedAllOperatorTransfer;
    }

    /**
     * @notice Smart contract owner only function
     *         Enables and disables artist minting.
     */
    function toggleArtistMinting() public onlyOwner {
        artistMinting = !artistMinting;
    }

    // ROYALTY MANAGEMENT //

    /**
     * @notice Smart contract owner only function.
     *         Function sets max royalty basis points.
     *
     * @param _maxRoyalty The max royalty basis points.
     */
    function setMaxRoyalty(uint96 _maxRoyalty) public onlyOwner {
        require(
            _maxRoyalty <= 10000,
            "The max royalty basis points can't be greater than 10000"
        );
        maxRoyalty = _maxRoyalty;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function sets smart contract owner royalty basis points.
     *
     * @param _ownerRoyalties The smart contract owner royalty basis points.
     */
    function setOwnerRoyalties(uint96 _ownerRoyalties) public onlyOwner {
        require(
            _ownerRoyalties <= 10000,
            "The owner royalty basis points can't be greater than 10000"
        );
        ownerRoyalties = _ownerRoyalties;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function sets portrait royalties.
     *
     * @param _portraitName      The portrait name.
     * @param _portraitRoyalties The portrait royalties.
     */
    function setPortraitRoyalties(
        string memory _portraitName,
        uint96 _portraitRoyalties
    ) public {
        require(isPortraitAdded[_portraitName] == true, "Portrait not added");
        require(
            msg.sender == owner() ||
                msg.sender == portraitArtist[_portraitName],
            "Caller incorrect"
        );
        require(
            _portraitRoyalties >= 0 && _portraitRoyalties <= maxRoyalty,
            "Incorrect portrait royalties entered"
        );
        portraitRoyalties[_portraitName] = _portraitRoyalties;
    }

    // PORTRAIT MANAGEMENT //

    /**
     * @notice Smart contract owner only function.
     *         Function adds new portrait.
     *
     * @param _portraitName      The portrait name.
     * @param _portraitArtist    The portrait artist.
     * @param _portraitRoyalties The portrait royalties.
     */
    function addNewPortrait(
        string memory _portraitName,
        address _portraitArtist,
        uint96 _portraitRoyalties
    ) public onlyOwner {
        require(
            isPortraitAdded[_portraitName] == false,
            "Portrait already added"
        );
        require(
            _portraitArtist != address(0),
            "Address can't be the zero address"
        );
        require(
            _portraitRoyalties >= 0 && _portraitRoyalties <= maxRoyalty,
            "Incorrect portrait royalties entered"
        );
        portraits.push(_portraitName);
        isPortraitAdded[_portraitName] = true;
        portraitArtist[_portraitName] = _portraitArtist;
        portraitRoyalties[_portraitName] = _portraitRoyalties;
    }

    /**
     * @notice Smart contract owner only function.
     *         Function removes portrait.
     *
     * @param _portraitName The portrait name.
     */
    function removePortrait(string memory _portraitName) public onlyOwner {
        require(isPortraitAdded[_portraitName] == true, "Portrait not added");
        uint256 index;
        for (uint256 i = 0; i < portraits.length; ++i) {
            if (
                keccak256(abi.encodePacked(portraits[i])) ==
                keccak256(abi.encodePacked(_portraitName))
            ) {
                index = i;
                break;
            }
        }
        portraits[index] = portraits[portraits.length - 1];
        portraits.pop();
        isPortraitAdded[_portraitName] = false;
        portraitArtist[_portraitName] = address(0);
        portraitRoyalties[_portraitName] = 0;
    }

    // OPERATOR MANAGEMENT //

    /**
     * @notice Smart contract owner only function.
     *         Function adds operators to the allowedOperators array.
     *
     * @param _addresses The operator addresses to be added.
     */
    function addAllowedOperator(
        address[] calldata _addresses
    ) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; ++i) {
            if (isOperatorAdded[_addresses[i]] == false) {
                allowedOperators.push(_addresses[i]);
                isOperatorAdded[_addresses[i]] = true;
            }
        }
    }

    /**
     * @notice Smart contract owner only function.
     *         Function removes operator from the allowedOperators array.
     *
     * @param _address The operator address to be removed.
     */
    function removeAllowedOperator(address _address) public onlyOwner {
        require(
            isOperatorAdded[_address] == true,
            "Operator has not been added"
        );
        uint256 index;
        for (uint256 i = 0; i < allowedOperators.length; ++i) {
            if (allowedOperators[i] == _address) {
                index = i;
                break;
            }
        }
        allowedOperators[index] = allowedOperators[allowedOperators.length - 1];
        allowedOperators.pop();
        isOperatorAdded[_address] = false;
    }

    // TRANSFER FUNCTION MODIFIED //

    /**
     * @dev See {IERC1155-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override {
        require(
            from == _msgSender() ||
                checkOperatorTransfer(from) == true ||
                msg.sender == galleryContract,
            "ERC1155: caller is not token owner or approved"
        );
        _safeTransferFrom(from, to, id, amount, data);
    }

    /**
     * @dev See {IERC1155-safeBatchTransferFrom}.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public virtual override {
        require(
            from == _msgSender() || checkOperatorTransfer(from) == true,
            "ERC1155: caller is not token owner or approved"
        );
        _safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    // GETTER FUNCTIONS, READ CONTRACT FUNCTIONS //

    /**
     * @notice Function returns the allowedOperators array.
     */
    function getAllowedOperators()
        public
        view
        returns (address[] memory _allowedOperators)
    {
        _allowedOperators = allowedOperators;
        return _allowedOperators;
    }

    /**
     * @notice Function returns the portraits array.
     */
    function getAllPortraits()
        public
        view
        returns (string[] memory allPortraits)
    {
        allPortraits = portraits;
        return allPortraits;
    }

    /**
     * @notice Function returns all the tokens of a portrait.
     *
     * @param _portraitName The portrait name.
     */
    function getAllPortraitTokenIds(
        string memory _portraitName
    ) public view returns (uint256[] memory tokenIds) {
        tokenIds = new uint256[](_totalMinted);
        uint256 counter = 0;
        for (uint256 i = 1; i <= _totalMinted; ++i) {
            if (
                keccak256(abi.encodePacked(_portraitName)) ==
                keccak256(abi.encodePacked(_tokenInfo[i].portraitName))
            ) {
                tokenIds[counter] = i;
                ++counter;
            }
        }
        assembly {
            mstore(tokenIds, counter)
        }
        return tokenIds;
    }

    /**
     * @notice Function queries and returns all the portrait tokenIds with the same edition type.
     *
     * @param _portraitName The portrait name.
     * @param _editionType  The edition type.
     */
    function getAllPortraitTokenIdsWithSameEditionType(
        string memory _portraitName,
        string memory _editionType
    ) public view returns (uint256[] memory tokenIds) {
        tokenIds = new uint256[](_totalMinted);
        uint256 counter = 0;
        for (uint256 i = 1; i <= _totalMinted; ++i) {
            if (
                keccak256(abi.encodePacked(_portraitName)) ==
                keccak256(abi.encodePacked(_tokenInfo[i].portraitName)) &&
                keccak256(abi.encodePacked(_editionType)) ==
                keccak256(abi.encodePacked(_tokenInfo[i].editionType))
            ) {
                tokenIds[counter] = i;
                ++counter;
            }
        }
        assembly {
            mstore(tokenIds, counter)
        }
        return tokenIds;
    }

    /**
     * @notice Function queries and returns all the portrait tokenIds with the same edition version.
     *
     * @param _portraitName   The portrait name.
     * @param _editionVersion The edition version.
     */
    function getAllPortraitTokenIdsWithSameEditionVersion(
        string memory _portraitName,
        uint256 _editionVersion
    ) public view returns (uint256[] memory tokenIds) {
        tokenIds = new uint256[](_totalMinted);
        uint256 counter = 0;
        for (uint256 i = 1; i <= _totalMinted; ++i) {
            if (
                keccak256(abi.encodePacked(_portraitName)) ==
                keccak256(abi.encodePacked(_tokenInfo[i].portraitName)) &&
                _editionVersion == _tokenInfo[i].editionVersion
            ) {
                tokenIds[counter] = i;
                ++counter;
            }
        }
        assembly {
            mstore(tokenIds, counter)
        }
        return tokenIds;
    }

    /**
     * @notice Function returns smart contract owner royalties.
     */
    function getOwnerRoyalties() public view returns (uint96) {
        return ownerRoyalties;
    }

    /**
     * @notice Function returns portrait artist.
     *
     * @param _portraitName The portrait name.
     */
    function getPortraitArtist(
        string memory _portraitName
    ) public view returns (address) {
        return portraitArtist[_portraitName];
    }

    /**
     * @notice Function returns portrait royalties.
     *
     * @param _portraitName The portrait name.
     */
    function getPortraitRoyalties(
        string memory _portraitName
    ) public view returns (uint96) {
        return portraitRoyalties[_portraitName];
    }

    /**
     * @notice Function queries and returns the token info for the entered tokenId.
     *
     * @param tokenId The tokenId.
     */
    function getTokenInfo(
        uint256 tokenId
    ) public view returns (TokenInfo memory tokenInfo) {
        tokenInfo = _tokenInfo[tokenId];
        return tokenInfo;
    }

    /**
     * @notice Function queries and returns whether the entered interfaceId is supported by this smart contract.
     *
     * @param interfaceId The interfaceId.
     */
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC1155, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    /// @notice Function returns total number of minted tokenIds.
    function totalMinted() public view returns (uint256) {
        return _totalMinted;
    }

    /**
     * @notice Function queries and returns the token uri for the entered tokenId.
     *
     * @param tokenId The tokenId.
     */
    function uri(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        string memory tokenUri = _tokenInfo[tokenId].editionUri;
        return tokenUri;
    }

    // INTERNAL FUNCTIONS //

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) {
        for (uint256 i = 0; i < ids.length; ++i) {
            if (
                keccak256(abi.encodePacked(_tokenInfo[ids[i]].editionType)) ==
                keccak256(abi.encodePacked("Artist Edition"))
            ) {
                require(
                    to == museumAddress,
                    "Artist editions are non-transferable to any other address which is not of the artist"
                );
            }
            if (
                keccak256(abi.encodePacked(_tokenInfo[ids[i]].editionType)) ==
                keccak256(abi.encodePacked("Museum Edition"))
            ) {
                require(
                    to == museumAddress,
                    "Museum editions are non-transferable to any other address which is not of the museum"
                );
            }
            if (
                keccak256(abi.encodePacked(_tokenInfo[ids[i]].editionType)) ==
                keccak256(abi.encodePacked("Gallery Edition")) &&
                from != address(0) &&
                to != owner()
            ) {
                require(
                    msg.sender == galleryContract,
                    "Only gallery contract can transfer gallery editions"
                );
                require(
                    _tokenInfo[ids[i]].editionVersion <= currentYear - 1,
                    "Can't be transferred in current year"
                );
            }
            if (
                keccak256(abi.encodePacked(_tokenInfo[ids[i]].editionType)) ==
                keccak256(abi.encodePacked("Gallery Edition")) &&
                from != address(0) &&
                to == owner()
            ) {
                require(
                    msg.sender == galleryContract,
                    "Only gallery contract can transfer gallery editions"
                );
                require(
                    _tokenInfo[ids[i]].editionVersion <= currentYear - 1,
                    "Can't be transferred in current year"
                );
            }
        }
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function checkOperatorTransfer(address from) internal view returns (bool) {
        if (allowedAllOperatorTransfer == true) {
            bool value = isApprovedForAll(from, _msgSender());
            return value;
        } else if (checkIfAllowedOperator(msg.sender) == true) {
            bool value = isApprovedForAll(from, _msgSender());
            return value;
        }
        return false;
    }

    function checkIfAllowedOperator(
        address msgSender
    ) internal view returns (bool) {
        if (allowedOperators.length > 0) {
            for (uint256 i = 0; i < allowedOperators.length; ++i) {
                if (allowedOperators[i] == msgSender) {
                    return true;
                }
            }
        }
        return false;
    }
}
