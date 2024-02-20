// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UploadIPFS {
    struct UploadMetadata {
        uint uploadedAt;
        string policyString;
        bytes32 ipfsHash;
    }

    mapping(address => UploadMetadata) public uploads;

    function upload(
        bytes32 ipfsHash,
        string memory policyString
    ) external returns (UploadMetadata memory newUpload) {
        newUpload.uploadedAt = block.timestamp;
        newUpload.policyString = policyString;
        newUpload.ipfsHash = ipfsHash;
        uploads[msg.sender] = newUpload;
        return newUpload;
    }
}
