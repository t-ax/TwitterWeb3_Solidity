
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract TwitterWeb3{
    uint totalMessagesCount;
    uint256 private randomPick;
    mapping(address => uint256) public lastWavedAt;

    event NewMessage(address indexed from, string message, string image, uint timestamp);


    struct Message {
        address sender;
        string message;
        string image; //it's a url
        uint timestamp;
    }

    Message[] listOfMessages;

    constructor() payable {
        randomPick = (block.timestamp + block.difficulty) % 100;
    }

    function sendMessage(string memory _message, string memory _image) public {


        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp,"Wait 15m");
        lastWavedAt[msg.sender] = block.timestamp;

        totalMessagesCount+=1;

        listOfMessages.push(Message(msg.sender, _message, _image, block.timestamp));

        randomPick = (block.difficulty + block.timestamp + randomPick) % 100;
        uint256 prizeAmount = 0.0001 ether;
        if (randomPick <= 50) {
            console.log("%s won!", msg.sender);
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewMessage(msg.sender, _message, _image, block.timestamp);
    }

    function getAllMessages() public view returns (Message[] memory) {
        return listOfMessages;
    }

    function getTotalMessagesCount() public view returns (uint) {
        
        return totalMessagesCount;
    }
}