const hardhat = require("hardhat");

async function deployIPFSUploader() {
  try {
    const IPFSUploader = await hardhat.ethers.getContractFactory(
      "IPFSUploader"
    );

    const contract = await IPFSUploader.deploy();
    console.log("Contract deployed at:", contract.target);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

deployIPFSUploader();
