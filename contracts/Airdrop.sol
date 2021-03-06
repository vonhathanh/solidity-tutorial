pragma solidity 0.6.12;

import "./utils/ECDSA.sol";

contract Airdrop {
    using ECDSA for bytes32;
    address public signer;
    address public token;
    mapping(address =>uint) balances;

    constructor(address _signer, address _token) public {
        signer = _signer;
        token = _token;
    }

    function addUser(address a, uint amount) external {
        balances[a] = amount;
    }

    function verifySignature(bytes32 hash, bytes memory signature) public view returns (bool){
        // 1. This recreates the message hash that was signed on the client.
        bytes32 messageHash = hash.toEthSignedMessageHash();
        // 2 & 3. Verify that the message's signer is the owner of the order
        if (messageHash.recover(signature) == signer)
            return true;
        return false;
    }

    function claim(uint amount, bytes memory signature) external {
        // 1. recreate message hash from inputs
        
        bytes32 hash = keccak256(abi.encodePacked(msg.sender, amount));
        if (verifySignature(hash, signature)) {
            (bool success, ) = token.call(abi.encodeWithSignature("transfer(address,uint256)", 
            msg.sender, amount));
            require(success, "not success in transfer token");
        }
        else {
            revert("Invalid signature");
        }
    }

    function getMessageHash(address _addr, uint256 _value) public view returns(bytes32) {
        return keccak256(abi.encodePacked(_addr, _value));
    }

    function getETHSignedMessageHash(bytes32 hash) public view returns(bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

}