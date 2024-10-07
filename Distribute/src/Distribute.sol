// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Distribute {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        // your code here
        // Check if there are adresses to idstibute to
        require(addresses.length > 0, "No addresses provided");

        // Get the total balance of the contract
        uint256 totalBalance = address(this).balance;

        // Calculate the amount to distribute to each address
        uint256 amountPerAddress = totalBalance / addresses.length;

        // Ensure that the contract has enough balance to distribute
        require(amountPerAddress > 0, "Insufficient balance to distribute");

        // Distribute Ether equally to all the provided address
        for (uint256 i = 0; i < addresses.length; i++) {
            // Transfer the calculated amount to each address
            payable(addresses[i]).transfer(amountPerAddress);
        }
    }

    // Fallback function to receive Ether
    receive() external payable {}
}
