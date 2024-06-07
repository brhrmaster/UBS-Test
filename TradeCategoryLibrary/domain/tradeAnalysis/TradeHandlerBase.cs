using TradeServiceLibrary.exception;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.domain.tradeAnalysis
{
    public abstract class TradeHandlerBase : ITradeHandler
    {
        private ITradeHandler next;

        public abstract string Handle(ITrade request);

        public ITradeHandler SetNext(ITradeHandler handler)
        {
            if (next == null)
            {
                next = handler;
            }
            else
            {
                next.SetNext(handler);
            }

            return this;
        }

        protected string GetNextHandlerValue(ITrade request)
        {
            return next != null ? next.Handle(request) : throw new UnknownException("UNKNOWN");
        }

        protected string Evaluate(bool isValidSector, bool isValidValue, string actualRisk, ITrade request)
        {
            try
            {
                return isValidSector && isValidValue ? actualRisk : GetNextHandlerValue(request);
            }
            catch (UnknownException ue)
            {
                return ue.Message;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
    }
}
