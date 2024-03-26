// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; 

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract AttributeToken is ERC1155, ERC1155Burnable {
    mapping(uint256 => address) public tokenCreators;
    uint256[] private allTokenIds;

    constructor() ERC1155("") {}

    function mintNewToken(
        address to,
        uint256 id,
        uint256 amount
    ) external {
        require(id > 0, "Token ID must be greater than 0");
        require(tokenCreators[id] == address(0), "Token ID already exists");
        
        tokenCreators[id] = msg.sender;
        allTokenIds.push(id);
        bytes memory defaultData = hex"12";
        _mint(to, id, amount, defaultData);
    }

    function mintExistingToken(
        address to,
        uint256 id,
        uint256 amount
    ) external {
        require(tokenCreators[id] != address(0), "Token does not exist");
        require(tokenCreators[id] == msg.sender, "Caller is not the creator of the token");

        bytes memory defaultData = hex"12";
        _mint(to, id, amount, defaultData);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public override {
        require(from == msg.sender, "Caller must be the token owner");
        require(tokenCreators[id] == msg.sender, "Caller is not the creator of the token");
        require(balanceOf(msg.sender, id) >= amount, "Caller does not have enough tokens");

        super.safeTransferFrom(from, to, id, amount, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public override {
        for (uint256 i = 0; i < ids.length; ++i) {
            require(from == msg.sender, "Caller must be the token owner");
            require(tokenCreators[ids[i]] == msg.sender, "Caller is not the creator of the token");
            require(balanceOf(msg.sender, ids[i]) >= amounts[i], "Caller does not have enough tokens");
        }
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    function VerifySignedAddress(bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s) public pure returns (address) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHashMessage = keccak256(abi.encodePacked(prefix, _hashedMessage));
        address signer = ecrecover(prefixedHashMessage, _v, _r, _s);
        return signer;
    }

    function generateAttributeList(address holder, bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s) public view returns (uint256[] memory) {
        address signer = VerifySignedAddress(_hashedMessage, _v, _r, _s);
        require(holder == signer, "Caller must sign message");

        uint256 tokenCount = 0;
        for (uint256 i = 0; i < allTokenIds.length; i++) {
            if (balanceOf(holder, allTokenIds[i]) > 0) {
                tokenCount++;
            }
        }

        uint256[] memory heldTokens = new uint256[](tokenCount);
        uint256 resultIndex = 0;
        for (uint256 i = 0; i < allTokenIds.length; i++) {
            if (balanceOf(holder, allTokenIds[i]) > 0) {
                heldTokens[resultIndex] = allTokenIds[i];
                resultIndex++;
            }
        }

        return heldTokens;

    }

}
