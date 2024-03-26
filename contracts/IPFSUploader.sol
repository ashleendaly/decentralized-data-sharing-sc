// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IPFSUploader {
    struct Upload {
        string policyString;
        string ipfsHash;
    }

    mapping(address => Upload[]) public uploads;

    function upload(string memory ipfsHash, string memory policyString) external returns (Upload memory newUpload) {
        newUpload.policyString = policyString;
        newUpload.ipfsHash = ipfsHash;
        uploads[msg.sender].push(newUpload);
        return newUpload;
    }

    function getAllUploadsForAddress(address user) external view returns (string[] memory policyStrings, string[] memory ipfsHashes) {
        uint256 length = uploads[user].length;
        policyStrings = new string[](length);
        ipfsHashes = new string[](length);

        for (uint256 i = 0; i < length; i++) {
            Upload storage _upload = uploads[user][i];
            policyStrings[i] = _upload.policyString;
            ipfsHashes[i] = _upload.ipfsHash;
        }
    }

}
