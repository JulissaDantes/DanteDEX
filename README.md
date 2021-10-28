# DanteDEX
There is the decentralized exchange that allow traders open position with leverage. Liquidity provided by stakers to exchange.
The task:

The trader can open or close positions on exchange. Implement Reward contract, that will reward traders for trading on exchange. The rewards should be calculated based on monthly bases. Trader can claim his rewards at any moment of time. The rewards calculation formula:

trader_monthly_reward = traders_trading_volume_per_month / amm_total_trading_volume_per_month
trader_total_reward = sum of all trader_monthly_reward while position was opened.

Limitations:

The solution should be fully decentralized. It means that it can't rely on keepers or any other external scripts. Any actions for accumulate/calculate the reward should be calculated only at the moment when someone open/close position or claim the rewards. There shouldn't be any for loops in the code. The complexity should be O(1)
Example

Month-1:

    Trader open the position with size = 100 (trader_volume = 100)
    The amm month1 total trading volume = 1000

Month-2:

    Trader decide to open one more position with size = 200 (trader_volume = 200)
    The amm month2 total trading volume = 500

Month-3:

    Trader do nothing, just keep his position open. (trader_volume = 0)
    But other traders trade and amm month3 total trading volume = 200

Month-4:

    Trader still do nothing, just keep his position open. (trader_volume = 0)
    But other traders trade and amm month-4 total trading volume = 200

Month-5:

    Trader still do nothing, just keep his position open. (trader_volume = 0)
    But other traders also do nothing so amm month-5 total trading volume = 0

Month-6:

    Trader decide to close all his positions. (trader_volume = 300)
    The total amm month-6 total trading volume = 1000

Month-8:

    Trader decides to claim his rewards the contract calculate the

total_reward = 100/1000 + 300/500 + 300/200 + 300/200 + 0 + 600/1000
