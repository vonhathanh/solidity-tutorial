pragma solidity 0.6.12;

import "./utils/Ownable.sol";
import "./utils/IERC20.sol";
import "./utils/Address.sol";

contract Vote is Ownable {
    using Address for address;

    using Address for address payable;

    mapping(address => bool) private voted;

    mapping(address => uint256) public voteCounter;

    IERC20 public rewardToken;

    event Voted(address voter, address politiciant, uint256 time);

    // only called one time
    constructor(address _token) public {
        rewardToken = IERC20(_token);
    }

    function vote(address politiciant) external returns (bool) {
        require(!address(msg.sender).isContract(), "not eoa");
        require(!voted[msg.sender], "you voted");
        voteCounter[politiciant] += 1;
        voted[msg.sender] = true;
        emit Voted(msg.sender, politiciant, block.timestamp);
    }

    function claimReward() external {
        require(voteCounter[msg.sender] > 1, "not enough vote");

        rewardToken.transfer(msg.sender, 1 ether);

        if (rewardToken.balanceOf(msg.sender) < 1 ether) {
            revert("not enought token");
        }

        msg.sender.sendValue(1 finney);
    }

    receive() external payable {}
}
