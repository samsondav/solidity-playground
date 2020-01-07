pragma solidity ^0.4.24;

import './lib/Mortal.sol';

contract Faucet is Mortal {
    uint constant MAX_WITHDRAWAL = 0.1 ether;
    // Give out ether to anybody who asks

    event Withdrawal(address indexed to, uint amount);
    event Deposit(address indexed from, uint amount);

    function withdraw(uint _amount) public {
        require(_amount <= MAX_WITHDRAWAL, "don't be greedy!");
        msg.sender.transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }

    function () public payable {
        emit Deposit(msg.sender, msg.value);
    }
}
