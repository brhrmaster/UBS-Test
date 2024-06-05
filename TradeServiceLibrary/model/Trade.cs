using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.model
{
    public class Trade : ITrade
    {
        public double Value { get; set; }
        public string ClientSector { get; set; }
    }
}
