//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//0x694AA1769357215DE4FAC081bf1f309aDC325306 sepolia eth/usdt price address

contract EtherPrice {

        AggregatorV3Interface internal pricefeed;
    constructor() {
        pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function getEtherLatestPrice() public view returns(int) {
        (,int price,,,) = pricefeed.latestRoundData();
        return price;
    }
}