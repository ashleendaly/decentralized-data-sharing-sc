// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract UploadIPFS {
    struct UploadMetadata {
        uint uploadedAt;
        string policyString;
        string ipfsHash;
    }

    mapping(address => UploadMetadata) public uploads;

    function upload(
        string memory ipfsHash,
        string memory policyString
    ) external returns (UploadMetadata memory newUpload) {
        newUpload.uploadedAt = block.timestamp;
        newUpload.policyString = policyString;
        newUpload.ipfsHash = ipfsHash;
        uploads[msg.sender] = newUpload;
        return newUpload;
    }
}
