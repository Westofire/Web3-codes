// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Todo{
    struct Task {
        string text;
        bool finished;
        uint256 createdAt;
    }

    mapping(address=>Task[]) public myTasks;
    event TaskAdded(address indexed user, string text);
    event TaskToggled(address indexed user, uint256 index, bool completed);
    event TaskDeleted(address indexed user, uint256);

    modifier validIndex(uint256 index){
    require(index < myTasks[msg.sender].length, "Index does not exist");
    _;
    }
    function addTask(string memory _text) public{
        myTasks[msg.sender].push(
            Task({
                text: _text,
                finished: true,
                createdAt: block.timestamp
            }
            )
        );
        emit TaskAdded(msg.sender, _text);
    }

    function toggleTask(uint256 index) public validIndex(index){
        require(index < myTasks[msg.sender].length, "Index does not exist");
        myTasks[msg.sender][index].finished=!myTasks[msg.sender][index].finished;

        emit TaskToggled(msg.sender, index, myTasks[msg.sender][index].finished);

    }

    function deleteTask(uint256 index) public validIndex(index){
       require(index < myTasks[msg.sender].length, "Index does not exist");
       uint256 lastIndex =  myTasks[msg.sender].length-1;
       myTasks[msg.sender][index]=myTasks[msg.sender][lastIndex];
       myTasks[msg.sender].pop;

       emit TaskDeleted(msg.sender, index);
    }
}