// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract UploadIPFS {
    struct UploadObject {
        string policyString;
        string ipfsHash;
    }

    mapping(address => UploadObject[]) public uploads;

    function upload(string memory ipfsHash, string memory policyString) external returns (UploadObject memory newUpload) {
        newUpload.policyString = policyString;
        newUpload.ipfsHash = ipfsHash;
        uploads[msg.sender].push(newUpload);
        return newUpload;
    }
}
