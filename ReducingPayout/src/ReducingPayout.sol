// SPDX-License-Identifier: BUSL-1.1  
pragma solidity ^0.8.13;  
  
contract ReducingPayout {  
  /*  
      This exercise assumes you know how block.timestamp works.  
      1. This contract has 1 ether in it, each second that goes by,  
        the amount that can be withdrawn by the caller goes from 100% to 0% as 24 hours passes.  
      2. Implement your logic in withdraw function.  
      Hint: 1 second deducts 0.0011574% from the current %.  
   */  
  
  // The time 1 ether was sent to this contract  
  uint256 public immutable depositedTime;  
  
  constructor() payable {  
    depositedTime = block.timestamp;  
  }  
  
  function withdraw() public {  
    // Calculate the time elapsed since the contract was deployed  
    uint256 timeElapsed = block.timestamp - depositedTime;  
  
    // Calculate the percentage of the total amount that can be withdrawn  
    // 1 second deducts 0.0011574% from the current %  
    uint256 percentage = 100000 - (timeElapsed * 11574 / 86400000);  
  
    // Calculate the amount that can be withdrawn  
    uint256 amount = address(this).balance * percentage / 100000;  
  
    // Transfer the amount to the caller  
    payable(msg.sender).transfer(amount);  
  }  
}
