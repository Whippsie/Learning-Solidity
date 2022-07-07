// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract FundMe {

    uint256 public minmumUsd = 50 * 1e18;

    //keyword "payable" permet de hold funds
    function fund() public payable{
        //msg est l'appel à la fonction, value est combien de cash il nous envoie
        //apres la virgule est "REVERT" si la condition pas respectée
        //revert : undo ce qui a été fait avant et renvoie le restant du gas
        //mais gas a été waste pour les computations, donc mettre require en début de fonction si possible pour sauver du gas
        require (msg.value >= minmumUsd, "Didn't send enough"); //1e18 == 1 * 10 ** 18 == 1 eth en wei 

        //on veut demander personne de donner au moins 50$, mais connait pas la valeur de eth sur le réseau
        //on fait donc appel à un oracle (insert monastry music here *ahhhhh*) 
    }

    //function withdraw(){}

    function getPrice() public view returns (uint256){
        //Veut parler à l'oracle (géré par chainlink) pour avoir le prix
        // Pour parler à un autre contrat : ABI et adresse

        //Exemple de contrat qui utilise Data feed
        // https://docs.chain.link/docs/get-the-latest-price/


        // ABI : Interface qui te dit les fonctions qui sont implémentées par le contrat
        // Adresse : https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        //fonction retourne tout ces champs
        //https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
        //(uint80 roundID, int price, uint startedAt, uint timeStamp, uint80 answerInRound) = priceFeed.latestRoundData();

        //Comme on s'en caliss sauf answer, on va juste cherche celui-là
        (,int256 price,,,) = priceFeed.latestRoundData();
        //price = eth en USD
        //mais il manque le point pour séparer décimal
        return uint256(price * 1e10); // 1**10 
        //autre problème : msg.value and un uint256 alors que notre price est int256, on va donc caster
    }
    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        //3000_000000000000000000 (18 zéros) ETH price in USD
        //1_000000000000000000 ETH
        //Doit tjs multiplier AVANT de diviser en solidity
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
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