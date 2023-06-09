//SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

contract MultiSigWallet {
    event Deposit(address indexed sender, uint amount);
    event Approve(address indexed owner, uint indexed txId);
    event Submit(uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed;

    }

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public required; // no of owners are required to approve

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public approved; 
    // this mapping will indicate whether the transaction is approved by the owner or not
    // this mapping takes index of transactions array and address of the owner who is approving the transaction and returns bool value

    modifier onlyOwner {
        require(isOwner[msg.sender],"You are not the owner!");
        _;
    }
    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "transaction does not exist");
        _;
    }
    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender] , "transation is not approved");
        _;
    }
    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "transaction already executed!");
        _;
    }
 
    constructor (address[] memory _owners, uint _required) {

        require(_owners.length > 0, "owner is required");
        require(_required > 0 && _required <= _owners.length, "required owner should be less than equal to number of owner");

        for(uint i = 0; i< _owners.length;i++){
            address owner = _owners[i];

            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction({
            to:_to,
            value:_value,
            data:_data,
            executed:false
        }));
        emit Submit(transactions.length -1);
    }

    function approve(uint _txId) 
        external 
        onlyOwner
        txExists(_txId)
        notApproved(_txId)
        notExecuted(_txId) 
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function getApprovalCount(uint _txId) private view returns(uint count) {
        for(uint i = 0; i < owners.length;i++){
            if(approved[_txId][owners[i]]){
                count++;
            }
         
        }
    }

    function execute(uint _txId) external txExists(_txId) notExecuted(_txId) {
        require(getApprovalCount(_txId) >= required, "approvals must be less than required ");

        Transaction storage transaction = transactions[_txId];

        transaction.executed = true;
        (bool success, ) = transaction.to.call{value:transaction.value}(transaction.data);
        require(success, "transaction failed!");

        emit Execute(_txId);
    }

    function revoke(uint _txId) external onlyOwner notExecuted(_txId) txExists(_txId) {
        require(approved[_txId][msg.sender], "transaction not approved");
        approved[_txId][msg.sender] = false;

        emit Revoke( msg.sender,_txId);
    }
}