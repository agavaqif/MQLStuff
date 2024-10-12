//+------------------------------------------------------------------+
//|                                            CPositionsManager.mqh |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property link      "https://www.mql5.com"

#define ALL_SYMBOLS ""
struct PositionStatus
  {
   // Account level positions
   int               accountBuyPositionsTotal;
   int               accountSellPositionsTotal;
   double            accountPositionsVolumeTotal;
   double            accountBuyPositionsVolumeTotal;
   double            accountSellPositionsVolumeTotal;
   double            accountBuyPositionsProfit;
   double            accountSellPositionsProfit;

   // Magic number specific positions
   int               magicPositionsTotal;
   int               magicBuyPositionsTotal;
   int               magicSellPositionsTotal;
   double            magicPositionsVolumeTotal;
   double            magicBuyPositionsVolumeTotal;
   double            magicSellPositionsVolumeTotal;
   double            magicPositionsProfit;
   double            magicBuyPositionsProfit;
   double            magicSellPositionsProfit;

   // Symbol specific positions
   int               symbolPositionsTotal;
   int               symbolBuyPositionsTotal;
   int               symbolSellPositionsTotal;
   double            symbolPositionsVolumeTotal;
   double            symbolBuyPositionsVolumeTotal;
   double            symbolSellPositionsVolumeTotal;
   double            symbolPositionsProfit;
   double            symbolBuyPositionsProfit;
   double            symbolSellPositionsProfit;

   // Constructor to initialize default values
                     PositionStatus()
     {
      accountBuyPositionsTotal = 0;
      accountSellPositionsTotal = 0;
      accountPositionsVolumeTotal = 0.0;
      accountBuyPositionsVolumeTotal = 0.0;
      accountSellPositionsVolumeTotal = 0.0;
      accountBuyPositionsProfit = 0.0;
      accountSellPositionsProfit = 0.0;
      magicPositionsTotal = 0;
      magicBuyPositionsTotal = 0;
      magicSellPositionsTotal = 0;
      magicPositionsVolumeTotal = 0.0;
      magicBuyPositionsVolumeTotal = 0.0;
      magicSellPositionsVolumeTotal = 0.0;
      magicPositionsProfit = 0.0;
      magicBuyPositionsProfit = 0.0;
      magicSellPositionsProfit = 0.0;
      symbolPositionsTotal = 0;
      symbolBuyPositionsTotal = 0;
      symbolSellPositionsTotal = 0;
      symbolPositionsVolumeTotal = 0.0;
      symbolBuyPositionsVolumeTotal = 0.0;
      symbolSellPositionsVolumeTotal = 0.0;
      symbolPositionsProfit = 0.0;
      symbolBuyPositionsProfit = 0.0;
      symbolSellPositionsProfit = 0.0;
     }

   // Function to print all fields
   void              PrintStatus()
     {
      Print("Account Buy Positions Total: ", accountBuyPositionsTotal);
      Print("Account Sell Positions Total: ", accountSellPositionsTotal);
      Print("Account Positions Volume Total: ", accountPositionsVolumeTotal);
      Print("Account Buy Positions Volume Total: ", accountBuyPositionsVolumeTotal);
      Print("Account Sell Positions Volume Total: ", accountSellPositionsVolumeTotal);
      Print("Account Buy Positions Profit: ", accountBuyPositionsProfit);
      Print("Account Sell Positions Profit: ", accountSellPositionsProfit);

      Print("Magic Positions Total: ", magicPositionsTotal);
      Print("Magic Buy Positions Total: ", magicBuyPositionsTotal);
      Print("Magic Sell Positions Total: ", magicSellPositionsTotal);
      Print("Magic Positions Volume Total: ", magicPositionsVolumeTotal);
      Print("Magic Buy Positions Volume Total: ", magicBuyPositionsVolumeTotal);
      Print("Magic Sell Positions Volume Total: ", magicSellPositionsVolumeTotal);
      Print("Magic Positions Profit: ", magicPositionsProfit);
      Print("Magic Buy Positions Profit: ", magicBuyPositionsProfit);
      Print("Magic Sell Positions Profit: ", magicSellPositionsProfit);

      Print("Symbol Positions Total: ", symbolPositionsTotal);
      Print("Symbol Buy Positions Total: ", symbolBuyPositionsTotal);
      Print("Symbol Sell Positions Total: ", symbolSellPositionsTotal);
      Print("Symbol Positions Volume Total: ", symbolPositionsVolumeTotal);
      Print("Symbol Buy Positions Volume Total: ", symbolBuyPositionsVolumeTotal);
      Print("Symbol Sell Positions Volume Total: ", symbolSellPositionsVolumeTotal);
      Print("Symbol Positions Profit: ", symbolPositionsProfit);
      Print("Symbol Buy Positions Profit: ", symbolBuyPositionsProfit);
      Print("Symbol Sell Positions Profit: ", symbolSellPositionsProfit);
     }
  };

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class CPositionsManager
  {
protected:
   MqlTradeRequest   tradeRequest;
   MqlTradeResult    tradeResult;
   bool              ErrorAdvisor(string callingFunc, string symbol, int tradeServerErrorCode);


public:
   void              CPositionsManager();
   bool              TradingIsAllowed();
   void              PrintOrderDetails(string header);
   bool              OpenBuyPosition(ulong magicNumber, string symbol, double lotSize, int sl, int tp, string positionComment);
   bool              OpenSellPosition(ulong magicNumber, string symbol, double lotSize, int sl, int tp, string positionComment);
   bool              SetSlTpByTicket(ulong positionTicket, int sl, int tp);
   bool              SetTrailingStopLoss(ulong positionTicket, int trailingStopLoss);
   bool              ClosePositionByTicket(ulong positionTicket);
   bool              CloseAllPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllBuyPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllSellPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllProfitablePositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllProfitableSellPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllProfitableBuyPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllLossPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllLossBuyPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   bool              CloseAllLossSellPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0);
   PositionStatus    GetPositionsData(string symbol, ulong magicNumber);
  };

//+------------------------------------------------------------------+
//| CisNewBar constructor.                                           |
//| INPUT:  no.                                                      |
//| OUTPUT: no.                                                      |
//| REMARK: no.                                                      |
//+------------------------------------------------------------------+
void CPositionsManager::CPositionsManager()
  {

  }


//------------------------------------------------------------------+
// ErrorAdvisor(): Error analysis and processing function.          |
// Returns true if order opening failed and order can be re-sent    |
// Returns false if the error is critical and can not be executed   |
//------------------------------------------------------------------+
bool CPositionsManager::ErrorAdvisor(string callingFunc, string symbol, int tradeServerErrorCode)
  {
//-- save the current runtime error code
   int runtimeErrorCode = GetLastError();

   switch(tradeServerErrorCode)//-- check for trade server errors
     {
      case 10004:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Requote!");
         Sleep(10);
         return(true);    //--- Exit the function and retry opening the order again
      case 10008:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Order placed!");
         return(false);    //--- success - order placed ok. exit function

      case 10009:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Request completed!");
         return(false);    //--- success - order placed ok. exit function

      case 10011:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Request processing error!");
         Sleep(10);
         return(true);    //--- Exit the function and retry opening the order again

      case 10012:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Request canceled by timeout!");
         Sleep(100);
         return(true);    //--- Exit the function and retry opening the order again

      case 10015:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Invalid price in the request!");
         Sleep(10);
         return(true);    //--- Exit the function and retry opening the order again

      case 10020:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Prices changed!");
         Sleep(10);
         return(true);    //--- Exit the function and retry opening the order again

      case 10021:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") There are no quotes to process the request!");
         Sleep(100);
         return(true);    //--- Exit the function and retry opening the order again

      case 10024:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") Too frequent requests!");
         Sleep(1000);
         return(true);    //--- Exit the function and retry opening the order again

      case 10031:
         Print(symbol, " - ", callingFunc, " ->(TradeServer_Code: ", tradeServerErrorCode, ") No connection with the trade server!");
         Sleep(100);
         return(true);    //--- Exit the function and retry opening the order again

      default:
         switch(runtimeErrorCode)//-- check for runtime errors
           {
            case 0:
               Print(symbol, " - ", callingFunc, " ->(Runtime_Code: ", runtimeErrorCode, ") The operation completed successfully!");
               ResetLastError(); //--- reset error cache
               return(false);    //--- Exit the function and stop trying to open order

            case 4752:
               Print(symbol, " - ", callingFunc, " ->(Runtime_Code: ", runtimeErrorCode, ") Trading by Expert Advisors prohibited!");
               ResetLastError(); //--- reset error cache
               return(false);    //--- Exit the function and stop trying to open order

            case 4753:
               Print(symbol, " - ", callingFunc, " ->(Runtime_Code: ", runtimeErrorCode, ") Position not found!");
               ResetLastError(); //--- reset error cache
               return(false);    //--- Exit the function and stop trying to open order

            case 4754:
               Print(symbol, " - ", callingFunc, " ->(Runtime_Code: ", runtimeErrorCode, ") Order not found!");
               ResetLastError(); //--- reset error cache
               return(false);    //--- Exit the function and stop trying to open order

            case 4755:
               Print(symbol, " - ", callingFunc, " ->(Runtime_Code: ", runtimeErrorCode, ") Deal not found!");
               ResetLastError(); //--- reset error cache
               return(false);    //--- Exit the function and stop trying to open order

            default: //--- All other error codes
               Print(symbol, " - ", callingFunc, " *OTHER* Error occurred \r\nTrade Server RetCode: ", tradeServerErrorCode, ", Runtime Error Code = ", runtimeErrorCode);
               ResetLastError(); //--- reset error cache
               return(false);    //--- Exit the function and stop trying to open order
               break;
           }
     }
  }


//+-----------------------------------------------------------------------+
//| TradingIsAllowed() verifies whether auto-trading is currently allowed |                                                                 |
//+-----------------------------------------------------------------------+
bool CPositionsManager::TradingIsAllowed()
  {
   if(
      !IsStopped() &&
      MQLInfoInteger(MQL_TRADE_ALLOWED) && TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) &&
      AccountInfoInteger(ACCOUNT_TRADE_ALLOWED) && AccountInfoInteger(ACCOUNT_TRADE_EXPERT)
   )
     {
      return(true);//-- trading is allowed, exit and return true
     }
   return(false);//-- trading is not allowed, exit and return false
  }


//+-----------------------------------------------------------------------+
//| PrintOrderDetails() prints the order details for the EA log           |
//+-----------------------------------------------------------------------+
void CPositionsManager::PrintOrderDetails(string header)
  {
   string orderDescription;
//-- Print the order details
   orderDescription += "_______________________________________________________________________________________\r\n";
   orderDescription += "--> "  + tradeRequest.symbol + " " + EnumToString(tradeRequest.type) + " " + header +
                       " <--\r\n";
   orderDescription += "Order ticket: " + (string)tradeRequest.order + "\r\n";
   orderDescription += "Volume: " + StringFormat("%G", tradeRequest.volume) + "\r\n";
   orderDescription += "Price: " + StringFormat("%G", tradeRequest.price) + "\r\n";
   orderDescription += "Stop Loss: " + StringFormat("%G", tradeRequest.sl) + "\r\n";
   orderDescription += "Take Profit: " + StringFormat("%G", tradeRequest.tp) + "\r\n";
   orderDescription += "Comment: " + tradeRequest.comment + "\r\n";
   orderDescription += "Magic Number: " + StringFormat("%d", tradeRequest.magic) + "\r\n";
   orderDescription += "Order filling: " + EnumToString(tradeRequest.type_filling)+ "\r\n";
   orderDescription += "Deviation points: " + StringFormat("%G", tradeRequest.deviation) + "\r\n";
   orderDescription += "RETCODE: " + (string)(tradeResult.retcode) + "\r\n";
   orderDescription += "Runtime Code: " + (string)(GetLastError()) + "\r\n";
   orderDescription += "---";
   Print(orderDescription);
  }


//-------------------------------------------------------------------+
// OpenBuyPosition(): Function to open a new buy entry order.        |
//+------------------------------------------------------------------+
bool CPositionsManager::OpenBuyPosition(ulong magicNumber, string symbol, double lotSize, int sl, int tp, string positionComment)
  {
//-- first check if the ea is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- reset the the tradeRequest and tradeResult values by zeroing them
   ZeroMemory(tradeRequest);
   ZeroMemory(tradeResult);

//-- initialize the parameters to open a buy position
   tradeRequest.type = ORDER_TYPE_BUY;
   tradeRequest.action = TRADE_ACTION_DEAL;
   tradeRequest.magic = magicNumber;
   tradeRequest.symbol = symbol;
   tradeRequest.tp = 0;
   tradeRequest.sl = 0;
   tradeRequest.comment = positionComment;
   tradeRequest.deviation = SymbolInfoInteger(symbol, SYMBOL_SPREAD) * 2;

//-- set and moderate the lot size or volume
   lotSize = MathMax(lotSize, SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN));  //-- Verify that volume is not less than allowed minimum
   lotSize = MathMin(lotSize, SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX));  //-- Verify that volume is not more than allowed maximum
   lotSize = MathFloor(lotSize / SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP)) * SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP); //-- Round down to nearest volume step
   tradeRequest.volume = lotSize;

//--- Reset error cache so that we get an accurate runtime error code in the ErrorAdvisor function
   ResetLastError();

   for(int loop = 0; loop <= 100; loop++) //-- try opening the order untill it is successful (100 max tries)
     {
      //--- update order opening price on each iteration
      tradeRequest.price = SymbolInfoDouble(symbol, SYMBOL_ASK);

      //-- set the take profit and stop loss on each iteration
      if(tp > 0)
        {
         tradeRequest.tp = NormalizeDouble(tradeRequest.price + (tp * _Point), _Digits);
        }
      if(sl > 0)
        {
         tradeRequest.sl = NormalizeDouble(tradeRequest.price - (sl * _Point), _Digits);
        }

      //--- send order to the trade server
      if(OrderSend(tradeRequest, tradeResult))
        {
         //-- Print the order details
         PrintOrderDetails("Sent OK");

         //-- Confirm order execution
         if(tradeResult.retcode == 10008 || tradeResult.retcode == 10009)
           {
            Print(__FUNCTION__, ": CONFIRMED: Successfully openend a ", symbol, " BUY POSITION #", tradeResult.order, ", Price: ", tradeResult.price);
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u", tradeResult.retcode, tradeResult.deal, tradeResult.order);
            Print("_______________________________________________________________________________________");
            return(true); //-- exit the function
            break; //--- success - order placed ok. exit the for loop
           }
        }
      else //-- Order request failed
        {
         //-- Print the order details
         PrintOrderDetails("Sending Failed");

         //-- order not sent or critical error found
         if(!ErrorAdvisor(__FUNCTION__, symbol, tradeResult.retcode) || IsStopped())
           {
            Print(__FUNCTION__, ": ", symbol, " ERROR opening a BUY POSITION at: ", tradeRequest.price, ", Lot\\Vol: ", tradeRequest.volume);
            Print("_______________________________________________________________________________________");
            return(false); //-- exit the function
            break; //-- exit the for loop
           }
        }
     }
   return(false);
  }


//-------------------------------------------------------------------+
// OpenSellPosition(): Function to open a new sell entry order.      |
//+------------------------------------------------------------------+
bool CPositionsManager::OpenSellPosition(ulong magicNumber, string symbol, double lotSize, int sl, int tp, string positionComment)
  {
//-- first check if the ea is allowed to trade
   if(!TradingIsAllowed())
     {
      //--- algo trading is disabled, exit function
      return(false);
     }

//-- reset the the tradeRequest and tradeResult values by zeroing them
   ZeroMemory(tradeRequest);
   ZeroMemory(tradeResult);

//-- initialize the parameters to open a sell position
   tradeRequest.type = ORDER_TYPE_SELL;
   tradeRequest.action = TRADE_ACTION_DEAL;
   tradeRequest.magic = magicNumber;
   tradeRequest.symbol = symbol;
   tradeRequest.tp = 0;
   tradeRequest.sl = 0;
   tradeRequest.comment = positionComment;
   tradeRequest.deviation = SymbolInfoInteger(symbol, SYMBOL_SPREAD) * 2;

//-- set and moderate the lot size or volume
   lotSize = MathMax(lotSize, SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN));  //-- Verify that volume is not less than allowed minimum
   lotSize = MathMin(lotSize, SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX));  //-- Verify that volume is not more than allowed maximum
   lotSize = MathFloor(lotSize / SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP)) * SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP); //-- Round down to nearest volume step
   tradeRequest.volume = lotSize;

   ResetLastError(); //--- reset error cache so that we get an accurate runtime error code in the ErrorAdvisor function

   for(int loop = 0; loop <= 100; loop++) //-- try opening the order (101 max) times untill it is successful
     {
      //--- update order opening price on each iteration
      tradeRequest.price = SymbolInfoDouble(symbol, SYMBOL_BID);

      //-- set the take profit and stop loss on each iteration
      if(tp > 0)
        {
         tradeRequest.tp = NormalizeDouble(tradeRequest.price - (tp * _Point), _Digits);
        }
      if(sl > 0)
        {
         tradeRequest.sl = NormalizeDouble(tradeRequest.price + (sl * _Point), _Digits);
        }

      //--- send order to the trade server
      if(OrderSend(tradeRequest, tradeResult))
        {
         //-- Print the order details
         PrintOrderDetails("Sent OK");

         //-- Confirm order execution
         if(tradeResult.retcode == 10008 || tradeResult.retcode == 10009)
           {
            Print("CONFIRMED: Successfully openend a ", symbol, " SELL POSITION #", tradeResult.order, ", Price: ", tradeResult.price);
            PrintFormat("retcode=%u  deal=%I64u  order=%I64u", tradeResult.retcode, tradeResult.deal, tradeResult.order);
            Print("_______________________________________________________________________________________");
            return(true); //-- exit function
            break; //--- success - order placed ok. exit for loop
           }
        }
      else  //-- Order request failed
        {
         //-- Print the order details
         PrintOrderDetails("Sending Failed");

         //-- order not sent or critical error found
         if(!ErrorAdvisor(__FUNCTION__, symbol, tradeResult.retcode) || IsStopped())
           {
            Print(symbol, " ERROR opening a SELL POSITION at: ", tradeRequest.price, ", Lot\\Vol: ", tradeRequest.volume);
            Print("_______________________________________________________________________________________");
            return(false); //-- exit function
            break; //-- exit for loop
           }
        }
     }
   return(false);
  }



//------------------------------------------------------------------------------+
// SetSlTpByTicket(): Sets the SL and TP from the provided pip value parameters |
//+-----------------------------------------------------------------------------+
bool CPositionsManager::SetSlTpByTicket(ulong positionTicket, int sl, int tp)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//--- Confirm and select the position using the provided positionTicket
   ResetLastError(); //--- Reset error cache incase of ticket selection errors
   if(PositionSelectByTicket(positionTicket))
     {
      //---Position selected
      Print("\r\n_______________________________________________________________________________________");
      Print(__FUNCTION__, ": Position with ticket:", positionTicket, " selected and ready to set SLTP.");
     }
   else
     {
      Print("\r\n_______________________________________________________________________________________");
      Print(__FUNCTION__, ": Selecting position with ticket:", positionTicket, " failed. ERROR: ", GetLastError());
      return(false); //-- Exit the function
     }

//-- create variables to store the calculated tp and sl prices to send to the trade server
   double tpPrice = 0.0, slPrice = 0.0;
   double newTpPrice = 0.0, newSlPrice = 0.0;

//--- Position ticket selected, save the position properties
   string positionSymbol = PositionGetString(POSITION_SYMBOL);
   double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double volume = PositionGetDouble(POSITION_VOLUME);
   double currentPositionSlPrice = PositionGetDouble(POSITION_SL);
   double currentPositionTpPrice = PositionGetDouble(POSITION_TP);
   ENUM_POSITION_TYPE positionType = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

//-- Get some information about the positions symbol
   int symbolDigits = (int)SymbolInfoInteger(positionSymbol, SYMBOL_DIGITS); //-- Number of symbol decimal places
   int symbolStopLevel = (int)SymbolInfoInteger(positionSymbol, SYMBOL_TRADE_STOPS_LEVEL);
   double symbolPoint = SymbolInfoDouble(positionSymbol, SYMBOL_POINT);
   double positionPriceCurrent = PositionGetDouble(POSITION_PRICE_CURRENT);
   int spread = (int)SymbolInfoInteger(positionSymbol, SYMBOL_SPREAD);

//--Save the non-validated tp and sl prices
   if(positionType == POSITION_TYPE_BUY) //-- Calculate and store the non-validated sl and tp prices
     {
      newSlPrice = entryPrice - (sl * symbolPoint);
      newTpPrice = entryPrice + (tp * symbolPoint);
     }
   else  //-- SELL POSITION
     {
      newSlPrice = entryPrice + (sl * symbolPoint);
      newTpPrice = entryPrice - (tp * symbolPoint);
     }

//-- Print position properties before modification
   string positionProperties = "--> "  + positionSymbol + " " + EnumToString(positionType) + " SLTP Modification Details" +
                               " <--\r\n";
   positionProperties += "------------------------------------------------------------\r\n";
   positionProperties += "Ticket: " + (string)positionTicket + "\r\n";
   positionProperties += "Volume: " + StringFormat("%G", volume) + "\r\n";
   positionProperties += "Price Open: " + StringFormat("%G", entryPrice) + "\r\n";
   positionProperties += "Current SL: " + StringFormat("%G", currentPositionSlPrice) + "   -> New Proposed SL: " + (string)newSlPrice + "\r\n";
   positionProperties += "Current TP: " + StringFormat("%G", currentPositionTpPrice) + "   -> New Proposed TP: " + (string)newTpPrice + "\r\n";
   positionProperties += "Comment: " + PositionGetString(POSITION_COMMENT) + "\r\n";
   positionProperties += "Magic Number: " + (string)PositionGetInteger(POSITION_MAGIC) + "\r\n";
   positionProperties += "---";
   Print(positionProperties);

//-- validate the sl and tp to a proper double that can be used in the OrderSend() function
   if(sl == 0)
     {
      slPrice = 0.0;
     }
   if(tp == 0)
     {
      tpPrice = 0.0;
     }

//--- Check if the sl and tp are valid in relation to the current price and set the tpPrice
   if(positionType == POSITION_TYPE_BUY)
     {
      //-- calculate the new sl and tp prices
      newTpPrice = 0.0;
      newSlPrice = 0.0;
      if(tp > 0)
        {
         newTpPrice = entryPrice + (tp * symbolPoint);
        }
      if(sl > 0)
        {
         newSlPrice = entryPrice - (sl * symbolPoint);
        }

      //-- save the new sl and tp prices incase they don't change afte validation below
      tpPrice = newTpPrice;
      slPrice = newSlPrice;

      if( //-- Check if specified TP is valid
         tp > 0 &&
         (
            newTpPrice <= entryPrice + (spread * symbolPoint) ||
            newTpPrice <= positionPriceCurrent ||
            (
               newTpPrice - entryPrice < symbolStopLevel * symbolPoint ||
               (positionPriceCurrent > entryPrice && newTpPrice - positionPriceCurrent < symbolStopLevel * symbolPoint)
            )
         )
      )
        {
         //-- Specified TP price is invalid, don't modify the TP
         Print(
            "Specified proposed ", positionSymbol,
            " TP Price at ", newTpPrice,
            " is invalid since current ", positionSymbol, " price is at ", positionPriceCurrent,
            "\r\nCurrent TP at ", StringFormat("%G", currentPositionTpPrice), " will not be changed!"
         );
         tpPrice = currentPositionTpPrice;
        }

      if( //-- Check if specified SL price is valid
         sl > 0 &&
         (
            newSlPrice >= positionPriceCurrent ||
            entryPrice - newSlPrice < symbolStopLevel * symbolPoint ||
            positionPriceCurrent - newSlPrice < symbolStopLevel * symbolPoint
         )
      )
        {
         //-- Specified SL price is invalid, don't modify the SL
         Print(
            "Specified proposed ", positionSymbol,
            " SL Price at ", newSlPrice,
            " is invalid since current ", positionSymbol, " price is at ", positionPriceCurrent,
            "\r\nCurrent SL at ", StringFormat("%G", currentPositionSlPrice), " will not be changed!"
         );
         slPrice = currentPositionSlPrice;
        }
     }
   if(positionType == POSITION_TYPE_SELL)
     {
      //-- calculate the new sl and tp prices
      newTpPrice = 0.0;
      newSlPrice = 0.0;
      if(tp > 0)
        {
         newTpPrice = entryPrice - (tp * symbolPoint);
        }
      if(sl > 0)
        {
         newSlPrice = entryPrice + (sl * symbolPoint);
        }

      //-- save the new sl and tp prices incase they don't change afte validation below
      tpPrice = newTpPrice;
      slPrice = newSlPrice;

      if( //-- Check if specified TP price is valid
         tp > 0 &&
         (
            newTpPrice >= entryPrice - (spread * symbolPoint) ||
            newTpPrice >= positionPriceCurrent ||
            (
               entryPrice - newTpPrice < symbolStopLevel * symbolPoint ||
               (positionPriceCurrent < entryPrice && positionPriceCurrent - newTpPrice < symbolStopLevel * symbolPoint)
            )
         )
      )
        {
         //-- Specified TP price is invalid, don't modify the TP
         Print(
            "Specified proposed ", positionSymbol,
            " TP Price at ", newTpPrice,
            " is invalid since current ", positionSymbol, " price is at ", positionPriceCurrent,
            "\r\nCurrent TP at ", StringFormat("%G", currentPositionTpPrice), " will not be changed!"
         );
         tpPrice = currentPositionTpPrice;
        }

      if( //-- Check if specified SL price is valid
         sl > 0 &&
         (
            newSlPrice <= positionPriceCurrent ||
            newSlPrice - entryPrice < symbolStopLevel * symbolPoint ||
            newSlPrice - positionPriceCurrent < symbolStopLevel * symbolPoint
         )
      )
        {
         //-- Specified SL price is invalid, don't modify the SL
         Print(
            "Specified proposed ", positionSymbol,
            " SL Price at ", newSlPrice,
            " is invalid since current ", positionSymbol, " price is at ", positionPriceCurrent,
            "\r\nCurrent SL at ", StringFormat("%G", currentPositionSlPrice), " will not be changed!"
         );
         slPrice = currentPositionSlPrice;
        }
     }

//-- Print verified position properties before modification
   positionProperties = "---\r\n";
   positionProperties += "--> Validated and Confirmed SL and TP: <--\r\n";
   positionProperties += "Price Open: " + StringFormat("%G", entryPrice) + ", Price Current: " + StringFormat("%G", positionPriceCurrent) + "\r\n";
   positionProperties += "Current SL: " + StringFormat("%G", currentPositionSlPrice) + "   -> New SL: " + (string)slPrice + "\r\n";
   positionProperties += "Current TP: " + StringFormat("%G", currentPositionTpPrice) + "   -> New TP: " + (string)tpPrice + "\r\n";
   Print(positionProperties);

//-- reset the the tradeRequest and tradeResult values by zeroing them
   ZeroMemory(tradeRequest);
   ZeroMemory(tradeResult);

//-- initialize the parameters to set the sltp
   tradeRequest.action = TRADE_ACTION_SLTP; //-- Trade operation type for setting sl and tp
   tradeRequest.position = positionTicket;
   tradeRequest.symbol = positionSymbol;
   tradeRequest.sl = slPrice;
   tradeRequest.tp = tpPrice;

   ResetLastError(); //--- reset error cache so that we get an accurate runtime error code in the ErrorAdvisor function

   for(int loop = 0; loop <= 100; loop++) //-- try modifying the sl and tp 101 times untill the request is successful
     {
      //--- send order to the trade server
      if(OrderSend(tradeRequest, tradeResult))
        {
         //-- Confirm order execution
         if(tradeResult.retcode == 10008 || tradeResult.retcode == 10009)
           {
            PrintFormat("Successfully modified SLTP for #%I64d %s %s", positionTicket, positionSymbol, EnumToString(positionType));
            PrintFormat("retcode=%u  runtime_code=%u", tradeResult.retcode, GetLastError());
            Print("_______________________________________________________________________________________\r\n\r\n");
            return(true); //-- exit function
            break; //--- success - order placed ok. exit for loop
           }
        }
      else  //-- Order request failed
        {
         //-- order not sent or critical error found
         if(!ErrorAdvisor(__FUNCTION__, positionSymbol, tradeResult.retcode) || IsStopped())
           {
            PrintFormat("ERROR modified SLTP for #%I64d %s %s", positionTicket, positionSymbol, EnumToString(positionType));
            Print("_______________________________________________________________________________________\r\n\r\n");
            return(false); //-- exit function
            break; //-- exit for loop
           }
        }
     }
   return(false);
  }



//-----------------------------------------------------------------------------------------------------+
// SetTrailingStopLoss(): Sets a trailing stop loss based on the provided ticket number parameters     |
//+----------------------------------------------------------------------------------------------------+
bool CPositionsManager::SetTrailingStopLoss(ulong positionTicket, int trailingStopLoss)
  {
//-- first check if the EA is allowed to trade and the trailing stop loss parameter is more than zero
   if(!TradingIsAllowed() || trailingStopLoss == 0)
     {
      return(false); //--- algo trading is disabled or trailing stop loss is invalid, exit function
     }

//--- Confirm and select the position using the provided positionTicket
   ResetLastError(); //--- Reset error cache incase of ticket selection errors
   if(!PositionSelectByTicket(positionTicket))
     {
      //---Position selection failed
      Print("\r\n_______________________________________________________________________________________");
      Print(__FUNCTION__, ": Selecting position with ticket:", positionTicket, " failed. ERROR: ", GetLastError());
      return(false); //-- Exit the function
     }

//-- create variable to store the calculated trailing sl prices to send to the trade server
   double slPrice = 0.0;

//--- Position ticket selected, save the position properties
   string positionSymbol = PositionGetString(POSITION_SYMBOL);
   double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double volume = PositionGetDouble(POSITION_VOLUME);
   double currentPositionSlPrice = PositionGetDouble(POSITION_SL);
   double currentPositionTpPrice = PositionGetDouble(POSITION_TP);
   ENUM_POSITION_TYPE positionType = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

//-- Get some information about the positions symbol
   int symbolDigits = (int)SymbolInfoInteger(positionSymbol, SYMBOL_DIGITS); //-- Number of symbol decimal places
   int symbolStopLevel = (int)SymbolInfoInteger(positionSymbol, SYMBOL_TRADE_STOPS_LEVEL);
   double symbolPoint = SymbolInfoDouble(positionSymbol, SYMBOL_POINT);
   double positionPriceCurrent = PositionGetDouble(POSITION_PRICE_CURRENT);
   int spread = (int)SymbolInfoInteger(positionSymbol, SYMBOL_SPREAD);

//-- Check if the trailing stop loss is less than the symbol trade stop levels
   if(trailingStopLoss < symbolStopLevel)
     {
      //-- Trailing stop loss is less than the allowed level for the current symbol
      trailingStopLoss = symbolStopLevel; //-- Set it to the symbol stop level by default
     }

//-- Calculate and store the trailing stop loss price
   if(positionType == POSITION_TYPE_BUY)
     {
      slPrice = positionPriceCurrent - (trailingStopLoss * symbolPoint);

      //-- Check if the proposed slPrice for the trailing stop loss is valid
      if(slPrice < entryPrice || slPrice < currentPositionSlPrice)
        {
         return(false); //-- Exit the function, proposed trailing stop loss price is invalid
        }
     }
   else  //-- SELL POSITION
     {
      slPrice = positionPriceCurrent + (trailingStopLoss * symbolPoint);

      //-- Check if the proposed slPrice for the trailing stop loss is valid
      if(slPrice > entryPrice || slPrice > currentPositionSlPrice)
        {
         return(false); //-- Exit the function, proposed trailing stop loss price is invalid
        }
     }

//-- Print position properties before setting the trailing stop loss
   string positionProperties = "--> "  + positionSymbol + " " + EnumToString(positionType) + " Trailing Stop Loss Modification Details" +
                               " <--\r\n";
   positionProperties += "------------------------------------------------------------\r\n";
   positionProperties += "Ticket: " + (string)positionTicket + "\r\n";
   positionProperties += "Volume: " + StringFormat("%G", volume) + "\r\n";
   positionProperties += "Price Open: " + StringFormat("%G", entryPrice) + "\r\n";
   positionProperties += "Current SL: " + StringFormat("%G", currentPositionSlPrice) + "   -> New Trailing SL: " + (string)slPrice + "\r\n";
   positionProperties += "Current TP: " + StringFormat("%G", currentPositionTpPrice) + "\r\n";
   positionProperties += "Comment: " + PositionGetString(POSITION_COMMENT) + "\r\n";
   positionProperties += "Magic Number: " + (string)PositionGetInteger(POSITION_MAGIC) + "\r\n";
   positionProperties += "---";
   Print(positionProperties);

//-- reset the the tradeRequest and tradeResult values by zeroing them
   ZeroMemory(tradeRequest);
   ZeroMemory(tradeResult);

//-- initialize the parameters to set the sltp
   tradeRequest.action = TRADE_ACTION_SLTP; //-- Trade operation type for setting sl and tp
   tradeRequest.position = positionTicket;
   tradeRequest.symbol = positionSymbol;
   tradeRequest.sl = slPrice;
   tradeRequest.tp = currentPositionTpPrice;

   ResetLastError(); //--- reset error cache so that we get an accurate runtime error code in the ErrorAdvisor function

   for(int loop = 0; loop <= 100; loop++) //-- try modifying the sl and tp 101 times untill the request is successful
     {
      //--- send order to the trade server
      if(OrderSend(tradeRequest, tradeResult))
        {
         //-- Confirm order execution
         if(tradeResult.retcode == 10008 || tradeResult.retcode == 10009)
           {
            PrintFormat("Successfully set the Trailing SL for #%I64d %s %s", positionTicket, positionSymbol, EnumToString(positionType));
            PrintFormat("retcode=%u  runtime_code=%u", tradeResult.retcode, GetLastError());
            Print("_______________________________________________________________________________________\r\n\r\n");
            return(true); //-- exit function
            break; //--- success - order placed ok. exit for loop
           }
        }
      else  //-- Order request failed
        {
         //-- order not sent or critical error found
         if(!ErrorAdvisor(__FUNCTION__, positionSymbol, tradeResult.retcode) || IsStopped())
           {
            PrintFormat("ERROR setting the Trailing SL for #%I64d %s %s", positionTicket, positionSymbol, EnumToString(positionType));
            Print("_______________________________________________________________________________________\r\n\r\n");
            return(false); //-- exit function
            break; //-- exit for loop
           }
        }
     }
   return(false);
  }




//-------------------------------------------------------------------------------------------+
// ClosePositionByTicket(): Closes a position based on the provided ticket number parameters |
//+------------------------------------------------------------------------------------------+
bool CPositionsManager::ClosePositionByTicket(ulong positionTicket)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//--- Confirm and select the position using the provided positionTicket
   ResetLastError(); //--- Reset error cache incase of ticket selection errors
   if(PositionSelectByTicket(positionTicket))
     {
      //---Position selected
      Print("...........................................................................................");
      Print(__FUNCTION__, ": Position with ticket:", positionTicket, " selected and ready to be closed.");
     }
   else
     {
      Print("...........................................................................................");
      Print(__FUNCTION__, ": Selecting position with ticket:", positionTicket, " failed. ERROR: ", GetLastError());
      return(false); //-- Exit the function
     }

//--- Position ticket selected, save the position properties
   string positionSymbol = PositionGetString(POSITION_SYMBOL);
   double positionVolume = PositionGetDouble(POSITION_VOLUME);
   ENUM_POSITION_TYPE positionType = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

//-- Print position properties before closing it
   string positionProperties;
   positionProperties += "-- "  + positionSymbol + " " + EnumToString(positionType) + " Details" +
                         " -------------------------------------------------------------\r\n";
   positionProperties += "Ticket: " + (string)positionTicket + "\r\n";
   positionProperties += "Volume: " + StringFormat("%G", PositionGetDouble(POSITION_VOLUME)) + "\r\n";
   positionProperties += "Price Open: " + StringFormat("%G", PositionGetDouble(POSITION_PRICE_OPEN)) + "\r\n";
   positionProperties += "SL: " + StringFormat("%G", PositionGetDouble(POSITION_SL)) + "\r\n";
   positionProperties += "TP: " + StringFormat("%G", PositionGetDouble(POSITION_TP)) + "\r\n";
   positionProperties += "Comment: " + PositionGetString(POSITION_COMMENT) + "\r\n";
   positionProperties += "Magic Number: " + (string)PositionGetInteger(POSITION_MAGIC) + "\r\n";
   positionProperties += "_______________________________________________________________________________________";
   Print(positionProperties);

//-- reset the the tradeRequest and tradeResult values by zeroing them
   ZeroMemory(tradeRequest);
   ZeroMemory(tradeResult);

//-- initialize the trade reqiest parameters to close the position
   tradeRequest.action = TRADE_ACTION_DEAL; //-- Trade operation type for closing a position
   tradeRequest.position = positionTicket;
   tradeRequest.symbol = positionSymbol;
   tradeRequest.volume = positionVolume;
   tradeRequest.deviation = SymbolInfoInteger(positionSymbol, SYMBOL_SPREAD) * 2;

//--- Set the price and order type of the position being closed
   if(positionType == POSITION_TYPE_BUY)
     {
      tradeRequest.price = SymbolInfoDouble(positionSymbol, SYMBOL_BID);
      tradeRequest.type = ORDER_TYPE_SELL;
     }
   else//--- For sell type positions
     {
      tradeRequest.price = SymbolInfoDouble(positionSymbol, SYMBOL_ASK);
      tradeRequest.type = ORDER_TYPE_BUY;
     }

   ResetLastError(); //--- reset error cache so that we get an accurate runtime error code in the ErrorAdvisor function

   for(int loop = 0; loop <= 100; loop++) //-- try closing the position 101 times untill the request is successful
     {
      //--- send order to the trade server
      if(OrderSend(tradeRequest, tradeResult))
        {
         //-- Confirm order execution
         if(tradeResult.retcode == 10008 || tradeResult.retcode == 10009)
           {
            Print(__FUNCTION__, "_________________________________________________________________________");
            PrintFormat("Successfully closed position #%I64d %s %s", positionTicket, positionSymbol, EnumToString(positionType));
            PrintFormat("retcode=%u  runtime_code=%u", tradeResult.retcode, GetLastError());
            Print("_______________________________________________________________________________________");
            return(true); //-- exit function
            break; //--- success - order placed ok. exit for loop
           }
        }
      else  //-- position closing request failed
        {
         //-- order not sent or critical error found
         if(!ErrorAdvisor(__FUNCTION__, positionSymbol, tradeResult.retcode) || IsStopped())
           {
            Print(__FUNCTION__, "_________________________________________________________________________");
            PrintFormat("ERROR closing position #%I64d %s %s", positionTicket, positionSymbol, EnumToString(positionType));
            Print("_______________________________________________________________________________________");
            return(false); //-- exit function
            break; //-- exit for loop
           }
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+

//-----------------------------------------------------------------------------+
// CloseAllPositions(): Closes all positions based on the provided symbol name |
// and magic number parameters.                                                |
//+----------------------------------------------------------------------------+
bool CPositionsManager::CloseAllPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

   bool returnThis = false;

//-- Scan for symbol and magic number specific positions and close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);

      //-- Filter positions by symbol and magic number
      if(
         (symbol != ALL_SYMBOLS && symbol != selectedSymbol) ||
         (magicNumber != 0 && positionMagicNo != magicNumber)
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }

//-- Confirm that we have closed all the positions being targeted
   int breakerBreaker = 0; //-- Variable that safeguards and makes sure we are not locked in an infinite loop
   PositionStatus status = GetPositionsData(symbol, magicNumber);
   while(status.symbolPositionsTotal > 0)
     {
      breakerBreaker++;
      CloseAllPositions(symbol, magicNumber); //-- We still have some open positions, do a function callback
      Sleep(100); //-- Micro sleep to pace the execution and give some time to the trade server

      //-- Check for critical errors so that we exit the loop if we run into trouble
      if(!ErrorAdvisor(__FUNCTION__, symbol, GetLastError()) || IsStopped() || breakerBreaker > 101)
        {
         break;
        }
     }

//-- Final confirmations that all targeted positions have been closed
   if(status.symbolPositionsTotal == 0)
     {
      returnThis = true; //-- Save this status for the function return value
     }

   return(returnThis);
  }

//------------------------------------------------------------------------------------+
// CloseAllBuyPositions(): Closes all buy positions based on the provided symbol name |
// and magic number parameters                                                        |
//+-----------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllBuyPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

   bool returnThis = false;

//-- Scan for symbol and magic number specific buy positions and close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      ulong positionType = PositionGetInteger(POSITION_TYPE);

      //-- Filter positions by symbol, type and magic number
      if(
         (symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (positionType != POSITION_TYPE_BUY) ||
         (magicNumber != 0 && positionMagicNo != magicNumber)
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }

//-- Confirm that we have closed all the buy positions being targeted
   int breakerBreaker = 0; //-- Variable that safeguards and makes sure we are not locked in an infinite loop
   PositionStatus status = GetPositionsData(symbol, magicNumber);

   while(status.symbolBuyPositionsTotal > 0)
     {
      breakerBreaker++;
      CloseAllBuyPositions(symbol, magicNumber); //-- We still have some open buy positions, do a function callback
      Sleep(100); //-- Micro sleep to pace the execution and give some time to the trade server

      //-- Check for critical errors so that we exit the loop if we run into trouble
      if(!ErrorAdvisor(__FUNCTION__, symbol, GetLastError()) || IsStopped() || breakerBreaker > 101)
        {
         break;
        }
     }

   if(status.symbolBuyPositionsTotal == 0)
     {
      returnThis = true;
     }
   return(returnThis);
  }


//--------------------------------------------------------------------------------------+
// CloseAllSellPositions(): Closes all sell positions based on the provided symbol name |
// and magic number parameters.                                                         |
//+-------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllSellPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

   bool returnThis = false;

//-- Scan for symbol and magic number specific sell positions and close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      ulong positionType = PositionGetInteger(POSITION_TYPE);

      //-- Filter positions by symbol, type and magic number
      if(
         (symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (positionType != POSITION_TYPE_SELL) ||
         (magicNumber != 0 && positionMagicNo != magicNumber)
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }

//-- Confirm that we have closed all the sell positions being targeted
   int breakerBreaker = 0; //-- Variable that safeguards and makes sure we are not locked in an infinite loop

   PositionStatus status = GetPositionsData(symbol, magicNumber);
   while(status.symbolSellPositionsTotal > 0)
     {
      breakerBreaker++;
      CloseAllSellPositions(symbol, magicNumber); //-- We still have some open sell positions, do a function callback
      Sleep(100); //-- Micro sleep to pace the execution and give some time to the trade server

      //-- Check for critical errors so that we exit the loop if we run into trouble
      if(!ErrorAdvisor(__FUNCTION__, symbol, GetLastError()) || IsStopped() || breakerBreaker > 101)
        {
         break;
        }
     }

   if(status.symbolSellPositionsTotal == 0)
     {
      returnThis = true;
     }
   return(returnThis);
  }


//--------------------------------------------------------------------------------------------------+
// CloseAllProfitablePositions(): Closes all profitable positions based on the provided symbol name |
// and magic number parameters.                                                                     |
//+-------------------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllProfitablePositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- Scan for profitable positions that match the specified symbol and magic number to close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      double positionProfit = PositionGetDouble(POSITION_PROFIT);

      //-- Filter positions by symbol, magic number and profit
      if(
         ((symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (magicNumber != 0 && positionMagicNo != magicNumber)) ||
         positionProfit <= 0
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }
   return(true);
  }

//---------------------------------------------------------------------------------------------------------+
// CloseAllProfitableBuyPositions(): Closes all profitable BUY positions based on the provided symbol name |
// and magic number parameters.                                                                            |
//+--------------------------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllProfitableBuyPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- Scan for profitable positions that match the specified symbol and magic number to close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      double positionProfit = PositionGetDouble(POSITION_PROFIT);

      //-- Filter positions by symbol, magic number, profit and type
      if(
         ((symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (magicNumber != 0 && positionMagicNo != magicNumber)) ||
         positionProfit <= 0 || PositionGetInteger(POSITION_TYPE) != POSITION_TYPE_BUY
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }
   return(true);
  }

//-----------------------------------------------------------------------------------------------------------+
// CloseAllProfitableSellPositions(): Closes all profitable SELL positions based on the provided symbol name |
// and magic number parameters.                                                                              |
//+----------------------------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllProfitableSellPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- Scan for profitable positions that match the specified symbol and magic number to close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      double positionProfit = PositionGetDouble(POSITION_PROFIT);

      //-- Filter positions by symbol, magic number, profit and type
      if(
         ((symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (magicNumber != 0 && positionMagicNo != magicNumber)) ||
         positionProfit <= 0 || PositionGetInteger(POSITION_TYPE) != POSITION_TYPE_SELL
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }
   return(true);
  }

//-----------------------------------------------------------------------------------------+
// CloseAllLossPositions(): Closes all loosing positions based on the provided symbol name |
// and magic number parameters.                                                            |
//+----------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllLossPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- Scan for loss positions that match the specified symbol and magic number and close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      double positionProfit = PositionGetDouble(POSITION_PROFIT);

      //-- Filter positions by symbol, magic number and profit
      if(
         ((symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (magicNumber != 0 && positionMagicNo != magicNumber)) ||
         positionProfit > 0
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }

   return(true);
  }

//------------------------------------------------------------------------------------------------+
// CloseAllLossBuyPositions(): Closes all loosing BUY positions based on the provided symbol name |
// and magic number parameters.                                                                   |
//+-----------------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllLossBuyPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- Scan for loss positions that match the specified symbol and magic number and close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      double positionProfit = PositionGetDouble(POSITION_PROFIT);

      //-- Filter positions by symbol, magic number, profit and type
      if(
         ((symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (magicNumber != 0 && positionMagicNo != magicNumber)) ||
         positionProfit > 0 || PositionGetInteger(POSITION_TYPE) != POSITION_TYPE_BUY
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }

   return(true);
  }

//--------------------------------------------------------------------------------------------------+
// CloseAllLossSellPositions(): Closes all loosing SELL positions based on the provided symbol name |
// and magic number parameters.                                                                     |
//+-------------------------------------------------------------------------------------------------+
bool CPositionsManager::CloseAllLossSellPositions(string symbol = ALL_SYMBOLS, ulong magicNumber = 0)
  {
//-- first check if the EA is allowed to trade
   if(!TradingIsAllowed())
     {
      return(false); //--- algo trading is disabled, exit function
     }

//-- Scan for loss positions that match the specified symbol and magic number and close them
   int totalOpenPositions = PositionsTotal();
   for(int x = 0; x < totalOpenPositions; x++)
     {
      //--- Get position properties
      ulong positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
      string selectedSymbol = PositionGetString(POSITION_SYMBOL);
      ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);
      double positionProfit = PositionGetDouble(POSITION_PROFIT);

      //-- Filter positions by symbol, magic number, profit and type
      if(
         ((symbol != ALL_SYMBOLS && symbol != selectedSymbol) || (magicNumber != 0 && positionMagicNo != magicNumber)) ||
         positionProfit > 0 || PositionGetInteger(POSITION_TYPE) != POSITION_TYPE_SELL
      )
        {
         continue;
        }

      //-- Close the position
      ClosePositionByTicket(positionTicket);
     }

   return(true);
  }

//---------------------------------------------------------------------------------------------------------------+
// GetPositionsData(): Gets and saves the status details of the account, symbols and expert advisor magic number |
// open positions in global variable that will be used to send data to different position status functions       |
//+--------------------------------------------------------------------------------------------------------------+
PositionStatus CPositionsManager::GetPositionsData(string symbol, ulong magicNumber)
  {
   PositionStatus posStatus;  // Create an instance of PositionStatus to hold the data

//-- Update and save the open positions status with realtime data
   int totalOpenPositions = PositionsTotal();
   if(totalOpenPositions > 0)
     {
      //-- Scan for symbol and magic number specific positions and save their status
      for(int x = 0; x < totalOpenPositions; x++)
        {
         //--- Get position properties
         ulong  positionTicket = PositionGetTicket(x); //-- Get ticket to select the position
         string selectedSymbol = PositionGetString(POSITION_SYMBOL);
         ulong positionMagicNo = PositionGetInteger(POSITION_MAGIC);

         //-- Filter positions by magic number
         if(magicNumber != 0 && positionMagicNo != magicNumber)
           {
            continue;
           }

         //-- Save the account positions status first
         posStatus.accountPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);

         if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
           {
            //-- Account properties
            ++posStatus.accountBuyPositionsTotal;
            posStatus.accountBuyPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
            posStatus.accountBuyPositionsProfit += PositionGetDouble(POSITION_PROFIT);
           }
         else //-- POSITION_TYPE_SELL
           {
            //-- Account properties
            ++posStatus.accountSellPositionsTotal;
            posStatus.accountSellPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
            posStatus.accountSellPositionsProfit += PositionGetDouble(POSITION_PROFIT);
           }

         //-- Filter positions openend by EA and save their status
         if(
            PositionGetInteger(POSITION_REASON) == POSITION_REASON_EXPERT &&
            positionMagicNo == magicNumber
         )
           {
            ++posStatus.magicPositionsTotal;
            posStatus.magicPositionsProfit += PositionGetDouble(POSITION_PROFIT);
            posStatus.magicPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
              {
               //-- Magic properties
               ++posStatus.magicBuyPositionsTotal;
               posStatus.magicBuyPositionsProfit += PositionGetDouble(POSITION_PROFIT);
               posStatus.magicBuyPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
              }
            else //-- POSITION_TYPE_SELL
              {
               //-- Magic properties
               ++posStatus.magicSellPositionsTotal;
               posStatus.magicSellPositionsProfit += PositionGetDouble(POSITION_PROFIT);
               posStatus.magicSellPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
              }
           }

         //-- Filter positions by symbol
         if(symbol == ALL_SYMBOLS || selectedSymbol == symbol)
           {
            ++posStatus.symbolPositionsTotal;
            posStatus.symbolPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
            posStatus.symbolPositionsProfit += PositionGetDouble(POSITION_PROFIT);
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
              {
               ++posStatus.symbolBuyPositionsTotal;
               posStatus.symbolBuyPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
               posStatus.symbolBuyPositionsProfit += PositionGetDouble(POSITION_PROFIT);
              }
            else //-- POSITION_TYPE_SELL
              {
               ++posStatus.symbolSellPositionsTotal;
               posStatus.symbolSellPositionsVolumeTotal += PositionGetDouble(POSITION_VOLUME);
               posStatus.symbolSellPositionsProfit += PositionGetDouble(POSITION_PROFIT);
              }
           }
        }
     }
// Return the populated PositionStatus struct
   return posStatus;
  }
//+------------------------------------------------------------------+
