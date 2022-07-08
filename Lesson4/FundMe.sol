// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";
contract FundMe {

    // Pour aucune raison que je comprends, il veut absolument utiliser msg.value.getConversionRate()
    // Doit donc déclarer la ligne ci-dessous pour pouvoir appeler des fonctions de PriceConverter
    // Directement sur un uint256
    using PriceConverter for uint256;
    uint256 public minmumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    //keyword "payable" permet de hold funds
    function fund() public payable{
        //msg est l'appel à la fonction, value est combien de cash il nous envoie
        //apres la virgule est "REVERT" si la condition pas respectée
        //revert : undo ce qui a été fait avant et renvoie le restant du gas
        //mais gas a été waste pour les computations, donc mettre require en début de fonction si possible pour sauver du gas
        // Ancienne méthode : require (getConversionRate(msg.value) >= minmumUsd, "Didn't send enough"); //1e18 == 1 * 10 ** 18 == 1 eth en wei 
        // Nouvelle avec lib :
        //require (msg.value.getConversionRate() >= minmumUsd, "Didn't send enough");
        require (msg.value.getConversionRate() >= 1, "Didn't send enough");
        // Multiple param
        msg.value.testMultipleParam(123);

        funders.push(msg.sender); //mot clé global caller de la fonction
        addressToAmountFunded[msg.sender] = msg.value;
        //on veut demander personne de donner au moins 50$, mais connait pas la valeur de eth sur le réseau
        //on fait donc appel à un oracle (insert monastry music here *ahhhhh*) 
    }

    //function withdraw(){}

    //voir price converter
}

//Dans un envoi etherscan
//20 bytes address paddé avec des 0 au début
//0000000000000000000000004f6742badb049791cd9a37ea913f2bac38d01279
//valeur du int paddé aussi
//0x3b0559f4 = 990206452
//000000000000000000000000000000000000000000000000000000003b0559f4


//Master this or perish forever
/*Use require()to:

Validate user inputs ie. require(input<20);
Validate the response from an external contract ie. require(external.send(amount));
Validate state conditions prior to execution, ie. require(block.number > SOME_BLOCK_NUMBER) or require(balance[msg.sender]>=amount)
Generally, you should use require most often
Generally, it will be used towards the beginning of a function*/

/*Use assert() to:

Check for overflow/underflow, ie. c = a+b; assert(c > b)
Check invariants, ie. assert(this.balance >= totalSupply);
Validate state after making changes
Prevent conditions which should never, ever be possible
Generally, you will probably use assert less often
Generally, it will be used towards the end of a function.*/