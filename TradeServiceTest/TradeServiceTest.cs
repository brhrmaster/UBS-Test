using ExpectedObjects;
using TradeServiceLibrary.adapter;
using TradeServiceLibrary.interfaces;
using TradeServiceLibrary.model;

namespace TradeServiceTest
{
    public class TradeServiceTest
    {

        [Fact(DisplayName = "Should get trade analisys with valid values")]
        public void ShouldGetTradeAnalisys()
        {
            var expectedResult = new string[4]
            {
                "HIGHRISK",
                "LOWRISK",
                "LOWRISK",
                "MEDIUMRISK"
            }.ToExpectedObject();

            var trade1 = new Trade { Value = 2000000, ClientSector = "Private" };
            var trade2 = new Trade { Value = 400000, ClientSector = "Public" };
            var trade3 = new Trade { Value = 500000, ClientSector = "Public" };
            var trade4 = new Trade { Value = 3000000, ClientSector = "Public" };

            var portfolio = new List<ITrade> { trade1, trade2, trade3, trade4 };

            var adapter = new TradeAdapter();
            var result = adapter.GetPortfolioAnalisys(portfolio);

            expectedResult.Matches(result);
        }

        [Fact(DisplayName = "Should get trade analisys with empty valid values")]
        public void ShouldGetTradeAnalisysEmptyValues()
        {
            var expectedResult = new string[4]
            {
                "HIGHRISK",
                "",
                "LOWRISK",
                ""
            }.ToExpectedObject();

            var trade1 = new Trade { Value = 2000000, ClientSector = "Private" };
            var trade2 = new Trade { Value = 1000000, ClientSector = "Private" };
            var trade3 = new Trade { Value = 5000000, ClientSector = "Public" };
            var trade4 = new Trade { Value = 500000, ClientSector = "Public" };

            var portfolio = new List<ITrade> { trade1, trade2, trade3, trade4 };

            var adapter = new TradeAdapter();
            var result = adapter.GetPortfolioAnalisys(portfolio);

            expectedResult.Matches(result);
        }
    }
}