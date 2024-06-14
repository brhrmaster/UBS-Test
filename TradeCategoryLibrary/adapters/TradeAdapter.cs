using TradeServiceLibrary.domain.tradeAnalysis;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.adapter
{
    public class TradeAdapter
    {
        private ITradeHandler tradeHandler;

        public TradeAdapter()
        {
            setupTradeCategoryChain();
        }


        private void setupTradeCategoryChain()
        {
            tradeHandler = new HighRiskHandler()
                .SetNext(new MediumRiskHandler())
                .SetNext(new LowRiskHandler());
        }

        /// <summary>
        /// Checks the client trade portfolio
        /// </summary>
        /// <param name="portfolio"></param>
        /// <returns>List of trade categories based on portfolio</returns>
        public string[] GetTradeCategories(List<ITrade> portfolio)
        {
            var results = new List<string>();

            foreach (var trade in portfolio)
            {
                results.Add(tradeHandler.Handle(trade));
            }

            return results.ToArray();
        }
    }
}
