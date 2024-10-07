// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Deployer {
    string public greeting;

    /* This exercise assumes you know how constructors works.
    The contract must have a constructor with a string argument
    that sets the greeting variable, if not it reverts. */
    constructor(string memory _greeting) {
        // Revert if the greeting is empty
        require(bytes(_greeting).length > 0, "Greeting cannot be empty");

        // Set the greeting variable
        greeting = _greeting;
    }
}