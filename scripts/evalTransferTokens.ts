async function transferTokens() {
  try {
    const walletAddress = "0x6C2127CEd02a0d9a3DC29A8BE472ecC72Ef7862d";
    const transferTo = "0xD705D599265f641E6e36a2E9072D047d7fA38443";

    const AttributeToken = await require("hardhat").ethers.getContractFactory(
      "AttributeToken"
    );

    const contractAddress = "0xAeb12d6683aa510ADe79770D01942080141dEA37";
    const contract = await AttributeToken.attach(contractAddress);

    const transferTimes: number[] = [];
    const numberOfTokensToTranfer: number[] = [];

    for (let i = 0; i < 150; i++) {
      const test = i + 1;

      const start = performance.now();
      await contract.safeTransferFrom(
        walletAddress,
        transferTo,
        test,
        test,
        "0x00"
      );
      const end = performance.now();
      const mintTime = end - start;
      transferTimes.push(mintTime);
      numberOfTokensToTranfer.push(test);
    }

    process.stdout.write(transferTimes + "\n");
    process.stdout.write(numberOfTokensToTranfer + "\n");
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

transferTokens();
