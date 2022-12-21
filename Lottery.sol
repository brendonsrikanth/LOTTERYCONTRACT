// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract LotteryContract {
    address public owner;
    address payable[] public players;

    constructor() {
        owner = msg.sender;
    }

    function getbalance() public view returns(uint){
        return address(this).balance;
    }

    function getplayers() public view returns(address payable[] memory){
        return players;
    }

    function enter() public payable{
        require(msg.value >= 1 ether);
        //address of player entering lottery
        players.push(payable(msg.sender));
    }
    function getRandomNumber() public view returns(uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public onlyowner {
        uint index = getRandomNumber() % players.length;
        players[index].transfer(address(this).balance);

        //reset the state of the contract
        players = new address payable[](0);
    }

    modifier onlyowner(){
        require(owner == msg.sender);
        _;
    }
}
    
     