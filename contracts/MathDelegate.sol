pragma solidity 0.6.12;

contract MathDelegate {
    uint public x = 10;
    address public mathlib;
    uint public pi;
    uint public result;

    bytes4 public addSign = bytes4(keccak256(abi.encodePacked("add(uint256)")));

    constructor(address lib) public {
        mathlib = lib;
    }

    // modify the zeroth number in the sequence
    function action(uint y) public returns(uint) {
        (bool success, bytes memory returnedData) = mathlib.delegatecall(abi.encodePacked(addSign, y));
        require(success, "action failed");
        result += abi.decode(returnedData, (uint));
    }

    fallback() external payable {
        (bool success, ) = mathlib.delegatecall(msg.data);
        require(success, "fallback failed");
    }
}