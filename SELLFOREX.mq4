//+------------------------------------------------------------------+
//|                                                   SELLSTOP10.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
//5k
void OnStart()
  {
//---
double x=Bid-10*_Point;
double y=2;
double z=1;
int stoploss=32;
int takeprofit1=16;
int takeprofit2=50;
   int order0=OrderSend(
                _Symbol,//currencyPair
                OP_SELLSTOP,//buy
                y,//howmuch
                x,//price
                3,//tolerance
                x+stoploss*_Point, //stoploss
                x-takeprofit1*_Point,//takeprofit
                NULL,//comment
                0,//magic number
                0,//expiration
                CLR_NONE//color of arrow
             );
   int order1=OrderSend(
                _Symbol,//currencyPair
                OP_SELLSTOP,//buy
                z,//howmuch
                x,//price
                3,//tolerance
                x+stoploss*_Point, //stoploss
                x-takeprofit2*_Point,//takeprofit
                NULL,//comment
                0,//magic number
                0,//expiration
                CLR_NONE//color of arrow
             );
  }
//+------------------------------------------------------------------+
