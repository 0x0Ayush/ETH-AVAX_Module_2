// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ENSMarketplace is ERC721URIStorage, Ownable {
    using SafeMath for uint256;

    uint256 private nextTokenId;
    mapping(uint256 => uint256) private tokenPrices;
    mapping(uint256 => bool) private tokensListedForSale;

    event ENSListedForSale(uint256 indexed tokenId, uint256 price);
    event ENSBought(uint256 indexed tokenId, address buyer, address seller, uint256 price);

    constructor() ERC721("ENSMarketplace", "ENSM") {}

    function createENS(string memory ensName) external {
        require(bytes(ensName).length > 0, "ENS name cannot be empty");

        uint256 tokenId = nextTokenId;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, ensName);
        nextTokenId = nextTokenId.add(1);
    }

    function listENSForSale(uint256 tokenId, uint256 price) external {
        require(ownerOf(tokenId) == msg.sender, "You are not the owner of the ENS domain");
        require(bytes(tokenURI(tokenId)).length > 0, "ENS domain does not exist");
        require(price > 0, "Price must be greater than zero");

        tokenPrices[tokenId] = price;
        tokensListedForSale[tokenId] = true;

        emit ENSListedForSale(tokenId, price);
    }

    function buyENS(uint256 tokenId) external payable {
        require(tokensListedForSale[tokenId], "ENS domain is not listed for sale");
        uint256 price = tokenPrices[tokenId];
        require(msg.value >= price, "Insufficient funds to buy ENS domain");

        address seller = ownerOf(tokenId);
        _transfer(seller, msg.sender, tokenId);
        tokensListedForSale[tokenId] = false;
        delete tokenPrices[tokenId];

        if (msg.value > price) {
            // Return excess funds to the buyer
            (bool successExcess, ) = msg.sender.call{value: msg.value.sub(price)}("");
            require(successExcess, "Failed to send excess funds back to the buyer");
        }

        (bool successSeller, ) = payable(seller).call{value: price}("");
        require(successSeller, "Failed to send Ether to the seller");

        emit ENSBought(tokenId, msg.sender, seller, price);
    }

    function getENSPrice(uint256 tokenId) external view returns (uint256) {
        return tokenPrices[tokenId];
    }

    function isTokenListedForSale(uint256 tokenId) external view returns (bool) {
        return tokensListedForSale[tokenId];
    }

    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        return tokenURI(tokenId);
    }
}
