//SPDX-License-Idetifier: MIT

pragma solidity ^0.8.19;

contract Immutable {

    // address public owner = msg.sender; // gas = 215496
    address public immutable owner = msg.sender; // gas = 189330

    uint x = 0;

    function foo() external {
        require(msg.sender==owner);
        x+=1;
    }

}