//SPDX-License-Identifier:MIT
 pragma solidity ^0.8.18;

 contract EtherWallet {
     
     address payable public owner;

     constructor() {
         owner = payable(msg.sender);
     }

     modifier checkOwner {
         require(msg.sender==owner, "You are not the owner of this wallet!");
            _;
     }
      
     receive() external payable {}

     function sendEther(uint _amount) checkOwner public payable {
         payable(msg.sender).transfer(_amount);
     }

     function getBalance() public view returns(uint) {
         return address(this).balance;
     }

     
 }