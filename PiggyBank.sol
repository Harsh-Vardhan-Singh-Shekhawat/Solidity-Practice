//SPDX-License-Identifier:MIT
pragma solidity ^ 0.8.18;

contract PiggyBank {

    event Deposit(uint _amount);
    event Withdraw(uint _amount);

    address public owner = msg.sender;

    receive() external payable {
       emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender==owner, "You are not the owner!");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}