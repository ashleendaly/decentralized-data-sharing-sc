import { personalSign } from "@metamask/eth-sig-util";
import Web3 from "web3";
require("dotenv").config();

export function signMessage(message: string) {
  const hashedMessage = Web3.utils.sha3(message);
  const privateKeyBuffer = Buffer.from(process.env.PRIVATE_KEY!, "hex");

  const signature = personalSign({
    privateKey: privateKeyBuffer,
    data: message,
  });
  const r = signature.slice(0, 66) as string;
  const s = ("0x" + signature.slice(66, 130)) as string;
  const v = parseInt(signature.slice(130, 132), 16);
  return { hashedMessage, v, r, s };
}

async function mint() {
  try {
    const { hashedMessage, v, r, s } = signMessage("test");

    const AttributeToken = await require("hardhat").ethers.getContractFactory(
      "AttributeToken"
    );

    const contractAddress = "0x17B1c04484EF3f2AF66784982A26624564b6a9C9";
    const contract = await AttributeToken.attach(contractAddress);

    const walletAddress = await contract.VerifySignedAddress(
      hashedMessage,
      v,
      r,
      s
    );

    const getGenerateAttributeListTimes: number[] = [];
    const numOfAttributes: number[] = [];

    for (let i = 0; i < 150; i++) {
      const test = i + 1;

      if (test % 5 == 0) {
        const start = performance.now();
        await contract.generateAttributeList(
          walletAddress,
          hashedMessage,
          v,
          r,
          s
        );
        const end = performance.now();
        const getGenerateAttributeListTime = end - start;
        getGenerateAttributeListTimes.push(getGenerateAttributeListTime);
        numOfAttributes.push(test);
      }

      await contract.mintNewToken(walletAddress, test, 1);
    }

    process.stdout.write(getGenerateAttributeListTimes + "\n");
    process.stdout.write(numOfAttributes + "\n");
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

mint();
