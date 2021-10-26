const main = async() => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const contractFactory = await hre.ethers.getContractFactory("TwitterWeb3");
    const contract =  await contractFactory.deploy();
    await contract.deployed();
    
    console.log("Deployed to the following address: ", contract.address);
    console.log("Deployed by the following address: ", owner.address);


    let messageTxn = await contract.sendMessage("This is a first test");
    await messageTxn.wait();

    let totalMessagesCount = await contract.getTotalMessagesCount();

    messageTxn = await contract.connect(randomPerson).sendMessage("This is another test");
    await messageTxn.wait();

    totalMessagesCount = await contract.getTotalMessagesCount();
    
    let listOfMessages = await contract.getAllMessages();
    console.log(listOfMessages);

}

const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();