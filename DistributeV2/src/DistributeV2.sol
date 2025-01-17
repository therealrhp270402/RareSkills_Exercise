// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract DistributeV2 {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
        3. Consider scenarios where one of the recipients rejects the ether transfer, 
           have a work around for that whereby other recipients still get their transfer
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        // your code here
        // Ensure that there are addresses to distribute to
        require(addresses.length > 0, "No addresses provided");

        // Get the total balance of the contract
        uint256 totalBalance = address(this).balance;

        // Calculate the amount to distribute to each address
        uint256 amountPerAddress = totalBalance / addresses.length;

        // Ensure that there is enough Ether to distribute
        require(amountPerAddress > 0, "Indusfficeint balance to distribute");

        // Distribute Ether to each address using a loop
        for(uint256 i = 0; i < addresses.length; i++) {
            (bool success, ) = payable(address[i]).call{value: amountPerAddress}("");
            require(success, "Tranfser failed to one of the addresses");
        }
    }

    receive() external payable {}
}
