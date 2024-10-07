// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Decoder {
    /* This exercise assumes you know how ABI decoding works.
        1. In the `decodeData` function below, write the logic that decodes a `bytes` data, based on the function parameters
        2. Return the decoded data
    */
    
    // Optional: For testing, you can store encoded data
    bytes public encoded;

    function decodeData(
        bytes memory _data
    ) public pure returns (string memory, uint256) {
        // Decode the bytes data into a string and a uint256
        (string memory decodedString, uint256 decodedNumber) = abi.decode(
            _data,
            (string, uint256)
        );

        return (decodedString, decodedNumber);
    }
}
