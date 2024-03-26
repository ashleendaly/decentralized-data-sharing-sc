async function upload() {
  try {
    const IPFSUploader = await require("hardhat").ethers.getContractFactory(
      "IPFSUploader"
    );

    const contractAddress = "0x829B8679FF4bf1633B689Fc19FCe1B2405b23De0";
    const contract = await IPFSUploader.attach(contractAddress);

    const uploadTimes: number[] = [];
    const getAllUploadTimes: number[] = [];
    const numOfUploads: number[] = [];

    for (let i = 0; i < 150; i++) {
      const test = i + 1;

      if (test % 5 == 0) {
        const start = performance.now();
        await contract.getAllUploadsForAddress(
          "0x6c8657BeBe7B984c34ADc5A19F4b9EAd5444dacC"
        );
        const end = performance.now();
        const getAllUploadTime = end - start;
        getAllUploadTimes.push(getAllUploadTime);
        numOfUploads.push(test);
      }

      const start = performance.now();
      await contract.upload(`hash-${test}`, `policy-string-${test}`);
      const end = performance.now();

      const uploadTime = end - start;
      uploadTimes.push(uploadTime);
    }

    process.stdout.write(uploadTimes + "\n");
    process.stdout.write(getAllUploadTimes + "\n");
    process.stdout.write(numOfUploads + "\n");
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

upload();
