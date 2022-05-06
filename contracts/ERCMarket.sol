pragma solidity 0.6.12;

import "./interfaces/IERC20.sol";
import "./utils/Ownable.sol";

contract ERCMarket is Ownable {
    IERC20 public token;

    uint PRICE = 2;

    constructor(IERC20 _token) public {
        token = _token;
    }

    function buy(uint amount)
     external payable {
        require(msg.value == amount, "invalid buy amount");
        token.transfer(msg.sender, amount * PRICE);
    }

    function withdraw() external onlyOwner{
        msg.sender.transfer(address(this).balance);
    }
}