pragma solidity 0.6.12;

contract FunctionSignature {
    function getSignatureOf(string memory func) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(func));
    }

    function getCalldata(string memory func, uint x) external view returns(bytes memory) {
        return abi.encodePacked(bytes4(keccak256(abi.encodePacked(func))), x);
    }
}