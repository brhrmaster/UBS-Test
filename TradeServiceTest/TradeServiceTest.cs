using ExpectedObjects;
using TradeServiceLibrary.adapter;
using TradeServiceLibrary.domain.models;
using TradeServiceLibrary.interfaces;

namespace TradeServiceTest
{
    public class TradeServiceTest
    {
        [Fact(DisplayName = "Should get trade analysis with valid values")]
        public void ShouldGetTradeAnalysis()
        {
            var expectedTradeCategories = new string[4]
            {
                "HIGHRISK",
                "LOWRISK",
                "LOWRISK",
                "MEDIUMRISK"
            };

            var portfolio = new List<ITrade> {
                new Trade { Value = 2000000, ClientSector = "Private" },
                new Trade { Value = 400000, ClientSector = "Public" },
                new Trade { Value = 500000, ClientSector = "Public" },
                new Trade { Value = 3000000, ClientSector = "Public" }
            };

            var adapter = new TradeAdapter();
            var tradeCategories = adapter.GetTradeCategories(portfolio);

            expectedTradeCategories.ToExpectedObject().ShouldEqual(tradeCategories);
        }

        [Fact(DisplayName = "Should get trade analysis with some invalid values")]
        public void ShouldGetTradeAnalysisSomeInvalidValues()
        {
            var expectedTradeCategories = new string[4]
            {
                "HIGHRISK",
                "UNKNOWN",
                "LOWRISK",
                "UNKNOWN"
            };

            var portfolio = new List<ITrade> {
                new Trade { Value = 2000000, ClientSector = "Private" },
                new Trade { Value = 1000000, ClientSector = "Private" },
                new Trade { Value = 500000, ClientSector = "Public" },
                new Trade { Value = 500000, ClientSector = "Private" }
            };

            var adapter = new TradeAdapter();
            var tradeCategories = adapter.GetTradeCategories(portfolio);

            expectedTradeCategories.ToExpectedObject().ShouldEqual(tradeCategories);
        }

        [Fact(DisplayName = "Should get trade analysis with empty list")]
        public void ShouldGetTradeAnalysisEmptyList()
        {
            var expectedTradeCategories = new string[0]{ };

            var portfolio = new List<ITrade> { };

            var adapter = new TradeAdapter();
            var tradeCategories = adapter.GetTradeCategories(portfolio);

            expectedTradeCategories.ToExpectedObject().ShouldEqual(tradeCategories);
        }

        [Fact(DisplayName = "Should get trade analysis with all invalid values")]
        public void ShouldGetTradeAnalysisAllInvalid()
        {
            var expectedTradeCategories = new string[4]
            {
                "UNKNOWN",
                "UNKNOWN",
                "UNKNOWN",
                "UNKNOWN"
            };

            var portfolio = new List<ITrade> {
                new Trade { Value = 20000, ClientSector = "Private" },
                new Trade { Value = 1000000, ClientSector = "Public" },
                new Trade { Value = 100000, ClientSector = "Private" },
                new Trade { Value = 1000, ClientSector = "Private" }
            };

            var adapter = new TradeAdapter();
            var tradeCategories = adapter.GetTradeCategories(portfolio);

            expectedTradeCategories.ToExpectedObject().ShouldEqual(tradeCategories);
        }
    }
}