pragma solidity 0.6.12;

contract A {
    uint v1;
    uint v2;

    function doOne(uint value) external {
        v1 = value;
    }

    function doTwo(uint value) external {
        v2 = value;
    }
}

contract B {
    address contractA;

    function execute(bytes memory data) external {
        (bool res, ) = contractA.call(data);
        require(res, "call to contract A failed");
    }
}

contract C {
    B contractB;

    function execute() external {
        contractB.execute(abi.encodeWithSignature("doOne(uint)"));
        contractB.execute(abi.encodeWithSignature("doTwo(uint)"));
    }
}