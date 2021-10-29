//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Reward {
    struct Trader{
        uint lastComputedMonth;//having the month I guess
        uint monthReward;
        uint traderTotalReward; 
        uint tradertotalVolume;
    }

    mapping(uint => uint) monthlyTradingVolume;//Saves trading volume sum per month
    mapping(address => Trader) traders;
    uint Month;

    constructor() {
        console.log("Deploying");
    }

    function open(uint size, uint currentMonth) public  {
        console.log("Opening");
        traders[msg.sender].tradertotalVolume += size;
        
        //if month is new compute all rewards
        if(Month < currentMonth){
           traders[msg.sender].lastComputedMonth = currentMonth;
           monthlyTradingVolume[currentMonth] = size;//Reset what was stored for that month before
           Month = currentMonth;
           traders[msg.sender].traderTotalReward += traders[msg.sender].monthReward;
           traders[msg.sender].monthReward = traders[msg.sender].tradertotalVolume/monthlyTradingVolume[currentMonth];
        }else{
           monthlyTradingVolume[currentMonth] += size;            
           traders[msg.sender].monthReward = traders[msg.sender].tradertotalVolume/monthlyTradingVolume[currentMonth];
        }
    }

    function close(uint size, uint currentMonth) public {
        console.log("Closing");
        traders[msg.sender].tradertotalVolume -= size;   
        monthlyTradingVolume[currentMonth] -= size;  
    }

    function withdraw() public returns(uint){
        console.log("The user got his reward");
        uint result = traders[msg.sender].traderTotalReward;
        traders[msg.sender].traderTotalReward = 0;
        return result;
    }
}
