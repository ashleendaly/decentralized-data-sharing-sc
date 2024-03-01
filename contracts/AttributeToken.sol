// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; 

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract AttributeToken is ERC1155, ERC1155Burnable {
    mapping(uint256 => address) public tokenCreators;

    constructor() ERC1155("") {}

    function mintNewToken(
        address to,
        uint256 id,
        uint256 amount
    ) external {
        require(id > 0, "Token ID must be greater than 0");
        require(tokenCreators[id] == address(0), "Token ID already exists");
        
        tokenCreators[id] = msg.sender;
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

    function callerIsTokenHolder(address senderToVerify, uint256 id) public view returns (bool) {
        return balanceOf(senderToVerify, id) > 0;
    }

}
