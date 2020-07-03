//+------------------------------------------------------------------+
//|                                                     CLOSEALL.mq4 |
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
void OnStart()
  {
//---
   for(int i=OrdersTotal(); i>=0; i--)
     {

      //select an order
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         //make sure its the right currency pair
         if(OrderSymbol()==_Symbol)
           {
            //check if buy or sell
            if((OrderType()==OP_BUY)||(OrderType()==OP_BUYSTOP))
              {
                 {
                  int closebuy=OrderClose(OrderTicket(),OrderLots(),Bid,3,NULL);
                 }
              }
            else
               if((OrderType()==OP_SELL)||(OrderType()==OP_SELLSTOP))
                 {
                  int closesell=OrderClose(OrderTicket(),OrderLots(),Ask,3,NULL);
                 }

           }
        }
     }
  }
//+------------------------------------------------------------------+
