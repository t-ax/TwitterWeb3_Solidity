
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract TwitterWeb3{
    uint totalMessagesCount;

    constructor(){
        console.log("aofhahepahgpahigpeahgpaeig");
    }

    function message() public {
        totalMessagesCount+=1;
        console.log("%s has waved", msg.sender);
    }

    function getTotalMessagesCount() public view returns (uint) {
        console.log("currently %d waves", totalMessagesCount);
        return totalMessagesCount;
    }
}