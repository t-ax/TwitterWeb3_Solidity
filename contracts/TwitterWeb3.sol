
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract TwitterWeb3{
    uint totalMessagesCount;

    event NewMessage(address indexed from, string message, uint timestamp);


    struct Message {
        address sender;
        string message;
        uint timestamp;
    }

    Message[] listOfMessages;

    constructor(){
        console.log("aofhahepahgpahigpeahgpaeig");
    }

    function sendMessage(string memory _message) public {
        totalMessagesCount+=1;
        console.log("%s has waved", msg.sender);

        listOfMessages.push(Message(msg.sender, _message, block.timestamp));
        emit NewMessage(msg.sender, _message, block.timestamp);
    }

    function getAllMessages() public view returns (Message[] memory) {
        return listOfMessages;
    }

    function getTotalMessagesCount() public view returns (uint) {
        console.log("currently %d waves", totalMessagesCount);
        return totalMessagesCount;
    }
}