const main = async() => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const contractFactory = await hre.ethers.getContractFactory("TwitterWeb3");
    const contract =  await contractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
      });
    await contract.deployed();
    
    let contractBalance = await hre.ethers.provider.getBalance(contract.address);
    console.log('Contract balance:',hre.ethers.utils.formatEther(contractBalance));

    console.log("Deployed to the following address: ", contract.address);
    console.log("Deployed by the following address: ", owner.address);


    let messageTxn = await contract.sendMessage("This is a first test","");
    await messageTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(contract.address);
    console.log('Contract balance:',hre.ethers.utils.formatEther(contractBalance));
    let totalMessagesCount = await contract.getTotalMessagesCount();

    messageTxn = await contract.connect(randomPerson).sendMessage("This is another test","");
    await messageTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(contract.address);
    console.log('Contract balance:',hre.ethers.utils.formatEther(contractBalance));
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