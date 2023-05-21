//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

contract Transfer {
    event TransferEvent(address from, address to, uint amount);
    event ChangeName(string name);

    string public name = "CTE";
    uint public id=1;

    function transfer(address payable to) public payable {
        to.transfer(msg.value);
        emit TransferEvent(msg.sender, to, msg.value);
    }

    function changeName(string calldata _name) public {
        name = _name;
        emit ChangeName(_name);
    }
    function changeId(string calldata _name) public {
        name = _name;
    }
}