pragma solidity 0.6.12;

contract FunctionSignature {
    function getSignatureOf(string memory func) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(func));
    }
}