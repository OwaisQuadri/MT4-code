//+------------------------------------------------------------------+
//|                                                    BUYSTOP10.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property script_show_inputs
input int pipsToStopLoss;
input int howFar;
input bool forex;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
   int pips=pipsToStopLoss;
   double risk=2000*0.02/1.3;
   double shares = (int)(risk / pips * 100);
   double maxShares = (int)(AccountFreeMargin()/1.3 * 14.8 / (Ask+howFar*_Point));
   if(forex)
     {
      shares/=100;
     }
   if(shares>500)
     {
      shares=500;
     }
   if(maxShares < shares)
     {
      shares = maxShares;
      pips=(int)(risk/shares*100);
     }

   Alert("Buy ",shares," shares of ", _Symbol);
   double x=Ask+howFar*_Point;
   double y=shares;
   int stoploss=pips;
   int takeprofit1=pips;
   int order0=OrderSend(
                 _Symbol,//currencyPair
                 OP_BUYSTOP,//buy
                 y,//howmuch*SYMBOL_VOLUME_MIN
                 x,//price
                 3,//tolerance
                 x-stoploss*_Point, //stoploss
                 x+takeprofit1*_Point,//takeprofit
                 NULL,//comment
                 0,//magic number
                 0,//expiration
                 CLR_NONE//color of arrow
              );
  }
//+------------------------------------------------------------------+
