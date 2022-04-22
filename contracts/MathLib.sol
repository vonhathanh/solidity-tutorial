pragma solidity 0.6.12;

contract MathLib {
    uint public x = 3;
    uint public pi = 4;

    function setPi(uint _pi) public {
        pi = _pi;
    }

    function add(uint y) external view returns(uint) {
        return x + y;
    }
}