// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPortraits {

    /** 
     * @dev Struct for storing token info.
     */
    struct TokenInfo {
        string portraitName;
        string editionType;
        uint256 editionAmount;
        uint256 editionVersion;
        string editionUri;
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
    ) external;

    /**
     * @dev See {IERC1155-balanceOf}.
     */
    function balanceOf(
        address account,
        uint256 id
    ) external view returns (uint256);

    /**
     * @dev Returns smart contract owner royalties.
     */
    function getOwnerRoyalties() external view returns (uint96);

    /**
     * @dev Returns portrait artist.
     */
    function getPortraitArtist(
        string memory _portraitName
    ) external view returns (address);

    /**
     * @dev Returns portrait royalties.
     */
    function getPortraitRoyalties(
        string memory _portraitName
    ) external view returns (uint96);

    /**
     * @dev Returns the token info for the tokenId.
     */
    function getTokenInfo(
        uint256 tokenId
    ) external view returns (TokenInfo memory tokenInfo);
}

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

pragma solidity ^0.8.0;

contract BuyAndSell is Ownable {
    // STATE VARIABLES //

    /// @notice Portrait contract address.
    address public portraitContract;

    /// @notice Boolean for enabling and disabling buy function.
    bool public canBuy;

    /// @notice Boolean for enabling and disabling cancelListing function.
    bool public canCancel;

    /// @notice Boolean for enabling and disabling listOnSaleOrUpdateActiveListing function.
    bool public canList;

    /// @notice Mapping for storing addresses which have active listings for tokenId.
    mapping(uint256 => address[]) private addressesListedForTokenId;

    /// @notice Mapping for storing whether address has active listing for tokenId.
    mapping(uint256 => mapping(address => bool))
        public islistedByAddressForTokenId;

    /// @notice Mapping for storing token listing info.
    mapping(uint256 => mapping(address => ListingInfo)) public tokenListingInfo;

    /// @notice Struct for storing listing info.
    struct ListingInfo {
        uint256 amount;
        uint256 pricePerCopy;
    }

    // EVENTS //

    /// @notice Event emitted when a sale happens.
    event SalesInfo(
        address _seller,
        address _buyer,
        uint256 _tokenId,
        uint256 _amount,
        uint256 _pricePerCopy,
        uint256 _totalPricePaid,
        uint256 royaltiesForArtist,
        uint256 royaltiesForOwner
    );

    /// @notice Event emitted when a new listing is created or existing listing is updated.
    event ActiveListing(
        address _seller,
        uint256 _tokenId,
        uint256 _amount,
        uint256 _pricePerCopy
    );

    /// @notice Event emitted when listing is cancelled.
    event ListingCancelled(address _seller, uint256 _tokenId);

    // SMART CONTRACT OWNER ONLY FUNCTIONS //

    /**
     * @notice Smart contract owner only function
     *         Function sets the portrait contract.
     *
     * @param _portraitContract The portrait contract address.
     */
    function setPortraitsContract(address _portraitContract) public onlyOwner {
        portraitContract = _portraitContract;
    }

    /**
     * @notice Smart contract owner only function
     *         Enables and disables buy function.
     */
    function toggleCanBuy() public onlyOwner {
        canBuy = !canBuy;
    }

    /**
     * @notice Smart contract owner only function
     *         Enables and disables cancelListing function.
     */
    function toggleCanCancel() public onlyOwner {
        canCancel = !canCancel;
    }

    /**
     * @notice Smart contract owner only function
     *         Enables and disables listOnSaleOrUpdateActiveListing function.
     */
    function toggleCanList() public onlyOwner {
        canList = !canList;
    }

    // LIST ON SALE, BUY AND CANCEL LISTING FUNCTIONS //

    /**
     * @notice Public function.
     *         Function lists entered amount of tokenId on sale.
     *
     * @param _tokenId      The tokenId.
     * @param _amount       The tokenId amount.
     * @param _pricePerCopy The price per copy of tokenId.
     */
    function listOnSaleOrUpdateActiveListing(
        uint256 _tokenId,
        uint256 _amount,
        uint256 _pricePerCopy
    ) public {
        require(canList == true, "Listing not enabled");
        require(
            _amount > 0 &&
                _amount <=
                IPortraits(portraitContract).balanceOf(msg.sender, _tokenId),
            "Amount must be greater than zero and must be less than or equal to the balance of the caller for the entered tokenId"
        );
        require(
            keccak256(
                abi.encodePacked(
                    IPortraits(portraitContract)
                        .getTokenInfo(_tokenId)
                        .editionType
                )
            ) == keccak256(abi.encodePacked("Commercial Edition")),
            "Only commercial edition is allowed to be sold"
        );
        require(
            _pricePerCopy >= 0,
            "Price per copy must be greater than or equal to zero"
        );
        tokenListingInfo[_tokenId][msg.sender].amount = _amount;
        tokenListingInfo[_tokenId][msg.sender].pricePerCopy = _pricePerCopy;
        if (islistedByAddressForTokenId[_tokenId][msg.sender] == false) {
            addressesListedForTokenId[_tokenId].push(msg.sender);
            islistedByAddressForTokenId[_tokenId][msg.sender] = true;
        }
        emit ActiveListing(msg.sender, _tokenId, _amount, _pricePerCopy);
    }

    /**
     * @notice Public function.
     *         Function allows to buy entered amount of tokenId on sale.
     *
     * @param _seller  The seller's address.
     * @param _tokenId The tokenId.
     * @param _amount  The tokenId amount.
     */
    function buy(
        address _seller,
        uint256 _tokenId,
        uint256 _amount
    ) public payable {
        require(canBuy == true, "Buying not enabled");
        require(
            tokenListingInfo[_tokenId][_seller].amount > 0,
            "No listing available for tokenId by seller"
        );
        require(
            _amount > 0 &&
                _amount <= tokenListingInfo[_tokenId][_seller].amount,
            "Entered amount must be greater than zero and must be less than or equal to amount put for sale for the entered tokenId"
        );
        require(
            IPortraits(portraitContract).balanceOf(_seller, _tokenId) >=
                _amount,
            "Seller currently doesn't have the entered amount for tokenId"
        );
        uint256 copyPrice = tokenListingInfo[_tokenId][_seller].pricePerCopy;
        uint256 totalSalePrice = copyPrice * _amount;
        uint256 royaltiesForArtist = (totalSalePrice *
            IPortraits(portraitContract).getPortraitRoyalties(
                IPortraits(portraitContract).getTokenInfo(_tokenId).portraitName
            )) / 10000;
        uint256 royaltiesForOwner = (totalSalePrice *
            IPortraits(portraitContract).getOwnerRoyalties()) / 10000;
        require(
            msg.value >=
                totalSalePrice + royaltiesForArtist + royaltiesForOwner,
            "Not enough ether sent"
        );
        tokenListingInfo[_tokenId][_seller].amount -= _amount;
        if (tokenListingInfo[_tokenId][_seller].amount == 0) {
            tokenListingInfo[_tokenId][_seller].pricePerCopy = 0;
            uint256 indexOfAddress = findIndex(_tokenId, _seller);
            removeAddress(_tokenId, indexOfAddress);
            islistedByAddressForTokenId[_tokenId][_seller] = false;
        }
        IPortraits(portraitContract).safeTransferFrom(
            _seller,
            msg.sender,
            _tokenId,
            _amount,
            ""
        );
        Address.sendValue(payable(_seller), totalSalePrice);
        address portraitArtist = IPortraits(portraitContract).getPortraitArtist(
            IPortraits(portraitContract).getTokenInfo(_tokenId).portraitName
        );
        Address.sendValue(payable(portraitArtist), royaltiesForArtist);
        Address.sendValue(payable(owner()), royaltiesForOwner);
        emit SalesInfo(
            _seller,
            msg.sender,
            _tokenId,
            _amount,
            copyPrice,
            totalSalePrice,
            royaltiesForArtist,
            royaltiesForOwner
        );
    }

    /**
     * @notice Public function.
     *         Function cancels listing made by caller for entered tokenId.
     *
     * @param _tokenId The tokenId.
     */
    function cancelListing(uint256 _tokenId) public {
        require(canCancel == true, "Cancel listing not enabled");
        require(
            tokenListingInfo[_tokenId][msg.sender].amount > 0,
            "No active listing for tokenId by your address"
        );
        tokenListingInfo[_tokenId][msg.sender].amount = 0;
        tokenListingInfo[_tokenId][msg.sender].pricePerCopy = 0;
        uint256 indexOfAddress = findIndex(_tokenId, msg.sender);
        removeAddress(_tokenId, indexOfAddress);
        islistedByAddressForTokenId[_tokenId][msg.sender] = false;
        emit ListingCancelled(msg.sender, _tokenId);
    }

    // GETTER FUNCTION //

    /**
     * @notice Function queries and returns the array of addresses which have an active listing for tokenId.
     *
     * @param _tokenId The tokenId.
     */
    function getAddressesListedForTokenId(
        uint256 _tokenId
    ) public view returns (address[] memory _addresses) {
        _addresses = addressesListedForTokenId[_tokenId];
        return _addresses;
    }

    // INTERNAL FUNCTION //

    function findIndex(
        uint256 _tokenId,
        address _address
    ) internal view returns (uint256 index) {
        for (
            uint256 i = 0;
            i < addressesListedForTokenId[_tokenId].length;
            ++i
        ) {
            if (addressesListedForTokenId[_tokenId][i] == _address) {
                index = i;
                return index;
            }
        }
    }

    function removeAddress(uint256 _tokenId, uint256 index) internal {
        addressesListedForTokenId[_tokenId][index] = addressesListedForTokenId[
            _tokenId
        ][addressesListedForTokenId[_tokenId].length - 1];
        addressesListedForTokenId[_tokenId].pop();
    }
}

