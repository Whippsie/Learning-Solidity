// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage{

    //override
    //virtual et override

    //veut comportement différent parent, doit avoir mot clé override
    //Pour override, PARENT doit avoir virtual à la fin
    //ENFANT a override à la fin
    function store (uint256 _favoriteNumber) public override{
        favoriteNumber = _favoriteNumber + 5;
    }

}