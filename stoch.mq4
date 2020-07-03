//+------------------------------------------------------------------+
double initial;
double volume=0.05;
int tradeCount=0;
bool buy=false;
bool sell=false;
int sl=100;
double max=80;
double min=20;
double base=AccountBalance();
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

//4 EMAs 10 20 30 50
   double EMA10=iMA(_Symbol,_Period,9,0,MODE_EMA,PRICE_CLOSE,0);
   double EMA20=iMA(_Symbol,_Period,20,0,MODE_EMA,PRICE_CLOSE,0);
   double EMA50=iMA(_Symbol,_Period,50,0,MODE_SMA,PRICE_CLOSE,0);
   double EMA100=iMA(_Symbol,_Period,200,0,MODE_SMA,PRICE_CLOSE,0);
//
   double high=High[1];
   double low=Low[1];
   double open=Open[1];
   double close=Close[1];
   double body=open-close;
   double top,bot;
   double topratio,botratio;
   if(body>0)
     {
      top=high-close;
      bot=open-low;
     }
   else
      if(body<0)
        {
         top=high-open;
         bot=close-low;
        }
   if(body!=0)
     {
      topratio=top/(MathAbs(body));
      botratio=bot/(MathAbs(body));
     }
   else
     {
      //if body is 0
      topratio=0;
      botratio=0;
     }
   double sellratio=0;
   double buyratio=0;
   if((botratio!=0) || (topratio!=0))
     {
      sellratio=(botratio/topratio);
      buyratio=(topratio/botratio);
     }

//Account Balance
   double bal=AccountBalance();
   double RPT=bal*.02;
   double profit=bal-base;
//account number
   int accountNumber=AccountInfoInteger(ACCOUNT_LOGIN);
//entry logic
   int mamode=3;
   double k=iStochastic(NULL,0,5,3,3,0,mamode,MODE_MAIN,0);
   double d=iStochastic(NULL,0,5,3,3,0,mamode,MODE_SIGNAL,0);
   double k0=iStochastic(NULL,0,5,3,3,0,mamode,MODE_MAIN,1);
   double d0=iStochastic(NULL,0,5,3,3,0,mamode,MODE_SIGNAL,1);
   double k1=iStochastic(NULL,0,5,3,3,0,mamode,MODE_MAIN,2);
   double d1=iStochastic(NULL,0,5,3,3,0,mamode,MODE_SIGNAL,2);
   if(OrdersTotal()==0)
     {
      //what kind of trade


      //
      //stochastic 533+reversal hammers and EMAs
      //

      if(((k-d)>=7.5))
        {
         buy=true;
         sell=false;
        }
      else
         if(((k-d)<=-7.5))
           {
            sell=true;
            buy=false;
           }
         else
           {
            buy=false;
            sell=false;
           }
      //how to buy
      if(buyratio>=5)
        {
         if(sellratio>=5)
           {
            //both are above _
            //undecided candle
           }
         else
           {
            //topratio above _
            //bears in control = sell
            //check next candle to sell
            if(sell)
              {
               //if all ma's point down
               if((EMA10<=EMA20)&&(EMA20<=EMA50)&&(EMA50<=EMA100))
                 {
                  if((d0>d)&&(d0<max)&&(d>min+30))
                    {
                     if(body>0)
                       {
                        sell(volume,"533");
                       }
                    }
                 }
              }
           }
        }
      else
         if(sellratio>=3)
           {
            //botratio above _
            //bulls in control = buy
            //check next candle to buy
            if(buy)
              {
               //if all ma's point up
               if((EMA10>=EMA20)&&(EMA20>=EMA50)&&(EMA50>=EMA100))
                 {
                  if((d0<d)&&(d0>min)&&(d<(max-30)))
                    {
                     if(body<0)
                       {
                        buy(volume,"533");
                       }
                    }
                 }
              }
           }
         else
           {
            //neither
            //wierd candle then
           }

     }

//exit logic
   if(OrdersTotal()==1)
     {
      if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES))
        {
         //make sure its the right currency pair
         if(OrderSymbol()==_Symbol)
           {
            //what comment?
            string comment=OrderComment();
            if(comment=="533")
              {
               //check if buy or sell
               if(OrderType()==OP_BUY)
                 {

                  //STOCHASTIC T/P
                  if((k>=max))
                    {
                     CloseAll();
                    }
                 }
               else
                  if(OrderType()==OP_SELL)
                    {

                     //STOCHASTIC T/P
                     if((k<=min))
                       {
                        CloseAll();
                       }
                    }
              }
           }
        }


     }
//
//output
   Comment(
      "Account Number: ",accountNumber,"\n",
      "Account Balance: ",bal,"\n",
      "Risk Per Trade: ",RPT,"\n"
      "Number of Trades: ",tradeCount,"\n",
      "Profit: ",profit,"\n"
   );
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void buy(double vol,string comment)
  {
   string com=comment;
   if(comment== "none")
     {
      com=NULL;
     }
   int order=OrderSend(
                _Symbol,//currencyPair
                OP_BUY,//buy
                vol,//howmuch
                Ask,//price
                3,//tolerance
                0, //stoploss Ask-sl*_Point
                0,//no takeprofit
                com,//comment
                0,//magic number
                0,//expiration
                CLR_NONE//color of arrow


             );
   tradeCount++;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void sell(double vol,string comment)
  {
   string com=comment;
   if(comment== "none")
     {
      com=NULL;
     }
   int order=OrderSend(
                _Symbol,//currencyPair
                OP_SELL,//sell
                vol,//howmuch
                Bid,//price
                3,//tolerance
                0, //stoploss Ask+sl*_Point
                0,//no takeprofit
                com,//comment
                0,//magic number
                0,//expiration
                CLR_NONE//color of arrow
             );
   tradeCount++;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   CloseAll();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseAll()
  {
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
                  int closebuy=OrderClose(OrderTicket(),OrderLots(),Bid,3,Red);
                 }
              }
            else
               if((OrderType()==OP_SELL)||(OrderType()==OP_SELLSTOP))
                 {
                  int closesell=OrderClose(OrderTicket(),OrderLots(),Ask,3,Red);
                 }

           }
        }
     }
  }
//+------------------------------------------------------------------+
