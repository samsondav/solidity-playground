pragma solidity ^0.4.24;

import "./interfaces/FooInterface.sol";

contract TestCallingFooInterface {
    function call(address _callee) public returns (string) {
        // The contract to call which is expected to conform to MyInterface
        return FooInterface(_callee).foo();
    }
}
