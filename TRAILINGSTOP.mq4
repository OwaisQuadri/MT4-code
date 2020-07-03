//+------------------------------------------------------------------+
//|                                                 TRAILINGSTOP.mq4 |
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
      int pips=10;
      //select an order
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         //make sure its the right currency pair
         if(OrderSymbol()==_Symbol)
           {
            //check if buy or sell
            if(OrderType()==OP_BUY)
              {
               if((Ask>(OrderOpenPrice()+pips*_Point))&&(OrderStopLoss()<Ask-pips*_Point)&&(Ask>=OrderOpenPrice()))
                 {
                  bool evenbuy=OrderModify(OrderTicket(),OrderOpenPrice(),Ask-pips*_Point,OrderTakeProfit(),0);
                  if(!evenbuy)
                    {
                     Print("Failed to set Trailing Stop Point for order #",OrderTicket());
                    }
                  else
                    {
                     Print("Trailing Stop point has been set for order #",OrderTicket());
                    }
                 }
              }
            else
               if(OrderType()==OP_SELL)
                 {
                  if((Bid<(OrderOpenPrice()-pips*_Point))&&(OrderStopLoss()>Bid+pips*_Point)&&(Bid<=OrderOpenPrice()))
                    {
                     bool evensell=OrderModify(OrderTicket(),OrderOpenPrice(),Bid+pips*_Point,OrderTakeProfit(),0);
                     if(!evensell)
                       {
                        Print("Failed to set Trailing Stop Point for order #",OrderTicket());
                       }
                     else
                       {
                        Print("Trailing Stop point has been set for order #",OrderTicket());
                       }
                    }
                 }

           }
        }
     }
  }
//+------------------------------------------------------------------+
