// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

contract Transactions {
    uint256 public transactionsCount = 0;
    
    constructor() {}

    event Transfer(address from, address receiver , uint amount , string message, uint timestamp , string keyword );

    struct TransferStruct {
        address sender;
        address receiver;
        uint amount;
        string message;
        uint256 timestamp;
        string keyword;
    }
    TransferStruct[] transactions;

    function addToBlockchain( address payable receiver, uint amount,string memory message, string memory keyword) public {
        transactionsCount+=1;
        transactions.push(TransferStruct(msg.sender, receiver, amount, message, block.timestamp, keyword));

        emit Transfer(msg.sender, receiver, amount, message, block.timestamp,keyword);
    }

    function getAllTransactions() public view returns(TransferStruct[] memory) {
        return transactions;
    }
    function getTransactionsCount() public view returns(uint256) {
        return transactionsCount;
    }
}