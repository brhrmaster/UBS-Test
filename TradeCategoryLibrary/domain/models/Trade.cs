using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.domain.models
{
    public class Trade : ITrade
    {
        public double Value { get; set; }
        public string ClientSector { get; set; }
    }
}
