// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Typecast {
    /**
     * the goal of this exercise is to pass if msg.value is equal to the address of this contract or revert otherwise
     */

    function typeCast() external payable {
        // your code here
        require(msg.value == uint256(uint160(address(this))), "msg.value must be euqal to this contract's address");
    }
}
