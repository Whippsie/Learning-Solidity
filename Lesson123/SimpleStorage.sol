// SPDX-License-Identifier: MIT

// Any stable version and higher
pragma solidity ^0.8.8;

contract SimpleStorage {
    // boolean, uint, int, address, bytes, string
    // uint - unsigned, always positive
    // https://docs.soliditylang.org/en/latest/types.html
    // Rappel : 1 Byte = 8 bits
    // uint8 = 8 bits (0 to 255) uint8,16,32,64...256
    // bytes2,3,5...bytes32
    uint8 test = 255; //internal by default (contract and kids)
    bytes32 favoriteBytes = "cat"; // 0x12342342dsadsfsf

    //solidity index chaque variable à une valeur (0,1,2...)
    uint256 favoriteNumber; //initialized to zero by default

    //Puisque publique, donne une fonction view par defaut (getter)
    People[] public people;
    //array dynamique car pas de size dans les []
    uint256[] public favoriteNumberList;
   
    //même chose ici solidity index fav à 0 et name à 1
    People public person = People({favoriteNumber: 2, name: "Patrick"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    function store(uint256 _favoriteNumber) public virtual{
        favoriteNumber = _favoriteNumber;
    }

    //view (read state), pure (neither write nor read) DO NOT cost gas if called by user
    //calling function that reads from function that costs gas, also costs gas
    // that's because calling from blockchain costs money
    function retrieve() public view returns (uint256){
        return favoriteNumber;
    }


    function addPerson (string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People(_favoriteNumber, _name);
        people.push(newPerson);
        //people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    //si on call avec n'importe quel string qui existe pas, retourne 0 pour uint256
    mapping(string => uint256) public nameToFavoriteNumber;

}

/* 
ONLY for array, struct, mapping
string = array of bytes

6 Places you can store and access data
calldata - variable existe temporairement, NON MODIFIABLE APRÈS INSTANCIATION
memory - variable existe temporairement
storage - variable existe toujours
code
logs
stack
*/

