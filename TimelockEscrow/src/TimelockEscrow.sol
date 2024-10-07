// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    // Struct to store escrow details
    struct Escrow {
        uint256 amount;
        uint256 timestamp;
    }

    // Mapping to track escrow details for each buyer
    mapping(address => Escrow) public escrows;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        // Check if an active escrow exists for the buyer
        require(escrows[msg.sender].amount == 0, "Active escrow already exists");

        // Record the escrow details
        escrows[msg.sender] = Escrow({
            amount: msg.value,
            timestamp: block.timestamp
        });
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(msg.sender == seller, "Only seller can withdraw");
        Escrow memory escrow = escrows[buyer];

        // Ensure the escrow exists and 3 dyas have passed
        require(escrow.amount > 0, "No active escrow for this buyer");
        require(block.timestamp >= escrow.timestamp + 3 days, "Escrow is still locked");

        uint256 amount = escrow.amount;

        // Reset the escrow data
        escrows[buyer].amount = 0;

        // Transfer the funds to the seller
        payable(seller).transfer(amount);
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        Escrow memory escrow = escrows[msg.sender];

        // Ensure the escrow exists
        require(escrow.amount > 0, "No active escrow");

        // Ensure the buyer is withdrawing withinthe 3 day window
        require(block.timestamp < escrow.timestamp + 3 days, "Withdrawal window has passed");

        uint256 amount = escrow.amount;

        // Reset the escrow data
        escrows[msg.sender].amount = 0;

        // Transfer the funds back to the buyer
        payable(msg.sender).transfer(amount);
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return escrows[buyer].amount;
    }
}
