//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

contract SelfDestruct {
    constructor() payable {}

    function Kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() pure external returns(uint) {
        return 123;
    }
}

contract Helper {

    function getBalane() external view returns(uint) {
        return address(this).balance;
    }

    function Kill(address _kill) external {
        SelfDestruct(_kill).Kill();
    }
}