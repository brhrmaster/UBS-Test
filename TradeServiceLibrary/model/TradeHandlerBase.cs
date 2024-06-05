using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.model
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
            return next != null ? next.Handle(request) : "";
        }

        protected string Evaluate(bool isValidSector, bool isValidValue, string actualRisk, ITrade request)
        {
            return isValidSector && isValidValue ? actualRisk : GetNextHandlerValue(request);
        }
    }
}
