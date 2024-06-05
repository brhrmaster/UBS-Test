namespace TradeServiceLibrary.interfaces
{
    public interface ITradeHandler
    {
        public ITradeHandler SetNext(ITradeHandler handler);
        public string Handle(ITrade request);
    }
}
