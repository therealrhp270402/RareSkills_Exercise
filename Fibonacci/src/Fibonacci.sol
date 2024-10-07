// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Fibonacci {
    /*
        This exercise assumes you understand what Fibonacci sequence is.
        1. Function `fibonacci` takes a uint256 as argument and returns nth fibonacci number.
        
        Fibonacci sequence are 0,1,1,2,3,5,8,13,....
        
        calling fibonacci(6) would return 8, because the 6th Fibonacci number is 8.
    */

    function fibonacci(uint256 _position) public view returns (uint256) {
        // your code here
        // Base cases for Fibonacii(0) and Fibonacci(1)
        if(_position == 0) {
            return 0;
        } else if (_position == 1) {
            return 1;
        }

        // Variable to store Fibonacci(n-1) and Fibonacci(n-2)
        uint256 a = 0; // Fibonacci (0)
        uint256 b = 1; // Fibonacci (1)
        uint256 result;

        // Iterate and calculate Fibonacci numbers up to the required position
        for (uint256 i = 2; i <= _position; i++) {
            result = a + b;
            a = b;
            b = result;
        }

        return result;
    }
}
