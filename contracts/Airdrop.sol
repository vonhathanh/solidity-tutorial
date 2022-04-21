pragma solidity 0.6.12;

import "./utils/ECDSA.sol";

contract Airdrop {
    using ECDSA for bytes32;
    address public signer;
    address public token;

    constructor(address _signer, address _token) public {
        signer = _signer;
        token = _token;
    }

    function verifySignature(bytes32 hash, bytes memory signature) public view returns (bool){
        // This recreates the message hash that was signed on the client.
        bytes32 messageHash = hash.toEthSignedMessageHash();
        // Verify that the message's signer is the owner of the order
        if (messageHash.recover(signature) == signer)
            return true;
        return false;
    }

    function claim(uint amount, bytes memory signature) external {
        bytes32 hash = keccak256(abi.encodePacked(msg.sender, amount));
        if (verifySignature(hash, signature)) {
            (bool success, ) = token.call(abi.encodeWithSignature("transfer(address,uint256)", msg.sender, amount));
            require(success, "not success in transfer token");
        }
    }

    function getMessageHash(address _addr, uint256 _value) public view returns(bytes32) {
        return keccak256(abi.encodePacked(_addr, _value));
        
    }

    function getETHSignedMessageHash(bytes32 hash) public view returns(bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
        
    }

}