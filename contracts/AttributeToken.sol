// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20; 

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract AttributeToken is ERC1155, ERC1155Burnable {
    mapping(uint256 => address) public tokenCreators;

    constructor() ERC1155("") {}

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public {
        require(
            tokenCreators[id] == address(0) || tokenCreators[id] == msg.sender,
            "Token ID already exists and caller is not the creator"
        );
        
        if (tokenCreators[id] == address(0)) {
            tokenCreators[id] = msg.sender;
        }

        _mint(to, id, amount, data);

    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public {
        for (uint256 i = 0; i < ids.length; ++i) {
            require(
                 tokenCreators[ids[i]] == address(0) || tokenCreators[ids[i]] == msg.sender,
                "Token ID already exists and caller is not the creator"
            );

            if (tokenCreators[ids[i]] == address(0)) {
                tokenCreators[ids[i]] = msg.sender;
            }
        }
        _mintBatch(to, ids, amounts, data);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public override {
        require(
            from == tokenCreators[id]
        );
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
            require(
                from == tokenCreators[ids[i]]
            );
        }
        super.safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    function callerIsTokenHolder(address senderToVerify, uint256 id) public view returns (bool) {
        return balanceOf(senderToVerify, id) > 0;
    }
}
