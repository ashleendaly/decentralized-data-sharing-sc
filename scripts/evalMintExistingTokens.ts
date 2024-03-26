async function mintExistingTokens() {
  try {
    const walletAddress = "0x6C2127CEd02a0d9a3DC29A8BE472ecC72Ef7862d";

    const AttributeToken = await require("hardhat").ethers.getContractFactory(
      "AttributeToken"
    );

    const contractAddress = "0xAeb12d6683aa510ADe79770D01942080141dEA37";
    const contract = await AttributeToken.attach(contractAddress);

    const mintTimes: number[] = [];
    const numberOfTokensToMint: number[] = [];

    for (let i = 0; i < 150; i++) {
      const test = i + 1;

      const start = performance.now();
      await contract.mintExistingToken(walletAddress, test, test);
      const end = performance.now();
      const mintTime = end - start;
      mintTimes.push(mintTime);
      numberOfTokensToMint.push(test);
    }

    process.stdout.write(mintTimes + "\n");
    process.stdout.write(numberOfTokensToMint + "\n");
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

mintExistingTokens();
