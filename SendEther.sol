//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

contract sendEther {
    constructor () payable {}

    fallback() payable external {}

    function sendViaTransfer(address payable _to) public payable {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) public payable {
        bool check = _to.send(123);

        require(check, "send failed");
    }

    function sendViaCall(address payable _to) public payable {
        (bool success,) = _to.call{value:123}("");
        require(success,"call failed");
    }

}

contract receiveEther {
    event Log(uint gas, uint amount);

    receive() payable external {
        emit Log(gasleft(), msg.value);
    }

}