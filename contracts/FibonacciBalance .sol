pragma solidity 0.4.26;

contract FibonacciBalance {

    address public fibonacciLibrary;
    // the current Fibonacci number to withdraw
    uint public calculatedFibNumber;
    // the starting Fibonacci sequence number
    uint public start = 3;
    uint public withdrawalCounter;
    // the Fibonancci function selector
    bytes4 constant fibSig = bytes4(sha3("setFibonacci(uint256)"));

    // constructor - loads the contract with ether
    constructor(address _fibonacciLibrary) public payable {
        fibonacciLibrary = _fibonacciLibrary;
    }

    function withdraw() {
        withdrawalCounter += 1;
        // calculate the Fibonacci number for the current withdrawal user-
        // this sets calculatedFibNumber
        require(fibonacciLibrary.delegatecall(fibSig, withdrawalCounter));
        msg.sender.transfer(calculatedFibNumber * 1 ether);
    }

    // allow users to call Fibonacci library functions
    function() public {
        require(fibonacciLibrary.delegatecall(msg.data));
    }
}