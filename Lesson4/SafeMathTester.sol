// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester{
    uint8 public bigNumber = 255; //unchecked !

    function add() public {
        bigNumber = bigNumber + 1; //revient à 0 
    }

    //^0.8 va fail la transaction si on bust
    //en 0.8+ si on veut revert au comportement avant
    //unchecked {bigNumber = bigNumber + 1};

    //UNCHECKED == MORE GAS EFFICIENT
}
