// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Assembly {
    uint8 public x = 2**8-1;

    function add(uint8 y) public {
        x += y;
    }

    function sub(uint8 y) public {
        x -= y;
    }
}
