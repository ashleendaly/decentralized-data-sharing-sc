async function deployAttributeToken() {
  try {
    const AttributeToken = await require("hardhat").ethers.getContractFactory(
      "AttributeToken"
    );

    const contract = await AttributeToken.deploy();
    console.log("Contract deployed at:", contract.target);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

deployAttributeToken();
