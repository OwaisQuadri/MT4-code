# MT4-code
Scripts and expert advisors created from scratch in the mql4 programming language for MetaTrader 4:

stoch : expert advisor that is based on a stochastic ocsilator and reversal dojis (was profitable but will not trade very often)
BUYSTOCK/SELLSTOCK: Script to trade stocks and forex currency using a buy/sell-stop that trades the correct volume of stock or currency pair based on the stoploss that you want to set, along with the risk that is intended on the account. the inputs are: pipsToStoploss (where the stoploss should be set), howFar (where the buy/sell-stop should be set), and forex (a boolean: if true, then the volume would be divided by 2). 
BREAKEVEN: if any trade has passed 3 points more than the break even point, the stoploss will be moved up to break-even when this script is run.
CLOSEALL: all trades for the selected chart will be closed at market price.
TRAILINGSTOP: if any trade has passed 10 points more than the break even, the stoploss will be moved up to 10 points less than the market price like a trailing stop loss.
