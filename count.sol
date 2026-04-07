// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract counter{
    uint256 public number;
    address public owner;

    constructor() {
        owner = msg.sender;
        number = 0;
    }

    function increment () public {
        number = number + 1;
    }

    function decrement () public  {
        require(number > 0, "The count cannot go negative");
        number = number - 1;
    }

    function set(uint256 num) public {
        require(msg.sender==owner, "You are not the owner");
        number=num;
    }

  
    function reset() public {
        require(msg.sender==owner, "You are not the owner");
        number=0;

    }
}