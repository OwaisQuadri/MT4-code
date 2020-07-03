//+------------------------------------------------------------------+
//|                                                    BREAKEVEN.mq4 |
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
        int pips=3;
         //make sure its the right currency pair
         if(OrderSymbol()==_Symbol)
           {
            //check if buy or sell
            if(OrderType()==OP_BUY)
              {
               if(Ask>=(OrderOpenPrice()+pips*_Point))
                 {
                  bool evenbuy=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0);
                  if(!evenbuy)
                    {
                     Print("Failed to set Break Even Point for order #",OrderTicket());
                    }
                  else
                    {
                     Print("Break Even point has been set for order #",OrderTicket());
                    }
                 }
              }
            else
               if(OrderType()==OP_SELL)
                 {
                  if(Bid<=(OrderOpenPrice()-pips*_Point))
                    {
                     bool evensell=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0);
                     if(!evensell)
                       {
                        Print("Failed to set Break Even Point for order #",OrderTicket());
                       }
                     else
                       {
                        Print("Break Even point has been set for order #",OrderTicket());
                       }
                    }
                 }

           }
        }
     }
  }
//+------------------------------------------------------------------+
