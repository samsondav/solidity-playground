pragma solidity ^0.4.24;

contract Faucet {
    uint constant MAX_WITHDRAWAL = 0.1 ether;
    // Give out ether to anybody who asks

    function withdraw(uint _amount) public {
        require(_amount <= MAX_WITHDRAWAL, "don't be greedy!");
        msg.sender.transfer(_amount);
    }

    function () public payable {}
}
