// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//library == no state var && cant receive eth
// doit mettre fonctions "internal" au lieu de "public" (pas sure pourquoi encore...)
library PriceConverter {

    function getPrice() public view returns (uint256){
        //Veut parler à l'oracle (géré par chainlink) pour avoir le prix
        // Pour parler à un autre contrat : ABI et adresse

        //Exemple de contrat qui utilise Data feed
        // https://docs.chain.link/docs/get-the-latest-price/


        // ABI : Interface qui te dit les fonctions qui sont implémentées par le contrat
        // Adresse : https://docs.chain.link/docs/ethereum-addresses/
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

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

    function getVersion() public view returns (uint256){
        //Puisque library, peut pas déclarer une var publique en haut, doit répéter
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        //3000_000000000000000000 (18 zéros) ETH price in USD
        //1_000000000000000000 ETH
        //Doit tjs multiplier AVANT de diviser en solidity
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function testMultipleParam(uint256 ethAmount, uint256 somethingElse) public view {
    }

}