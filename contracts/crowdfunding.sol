// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title SimpleCrowdfunding
 * @dev A minimal crowdfunding smart contract for a DApp
 */
contract SimpleCrowdfunding {
    address public owner;
    uint256 public goalAmount;
    uint256 public totalFunds;

    mapping(address => uint256) public contributions;

    constructor(uint256 _goalAmount) {
        owner = msg.sender;
        goalAmount = _goalAmount;
    }

    // Function 1: Contribute funds to the campaign
    function contribute() external payable {
        require(msg.value > 0, "Contribution must be greater than zero");
        contributions[msg.sender] += msg.value;
        totalFunds += msg.value;
    }

    // Function 2: Withdraw funds (only owner & if goal reached)
    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        require(totalFunds >= goalAmount, "Goal not reached yet");

        payable(owner).transfer(address(this).balance);
    }

    // (Optional) Function 3: Get remaining amount to reach goal
    function getRemainingAmount() external view returns (uint256) {
        if (totalFunds >= goalAmount) {
            return 0;
        } else {
            return goalAmount - totalFunds;
        }
    }
}

