// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one 
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit, the endTime is 
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting 
           period has ended. It transfers the entire balance of the contract to the winner.
    */

    address public winner;
    uint256 public highestBet;
    uint256 public endTime;

    function bet() public payable {
        // your code here
        require(msg.value > 0, "You must deposit some ether");

        // Check if this bet is higher than the previous highest bet
        if(msg.value > highestBet) {
            highestBet = msg.value; // Update highest bet
            winner = msg.sender; // Update winner
            endTime = block.timestamp + 1 hours; // Extend betting period
        } else {
            revert("Your bet must be higher than the current highest bet.");
        }
    }

    function claimPrize() public {
        // your code here
        require(block.timestamp > endTime, "Betting period has not ended yet.");
        require(msg.sender == winner, "Only the winner can claim the prize.");

        // Tranfser teh entire balance of the contract to the winner
        uint256 prizeAmount = address(this).balance; // Get the baance o fthe contract
        (bool success, ) = winner.call{value: prizeAmount}(""); // Send the ether
        require(success, "Transfer failed");

        // Reset state variables
        highestBet = 0;
        winner = address(0);
        endTime = 0;
    }
}
