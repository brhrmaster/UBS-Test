using TradeServiceLibrary.domain.tradeAnalysis;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.adapter
{
    public class TradeAdapter
    {
        /// <summary>
        /// Checks the client trade portfolio
        /// </summary>
        /// <param name="portfolio"></param>
        /// <returns>List of trade categories based on portfolio</returns>
        public string[] GetPortfolioAnalysis(List<ITrade> portfolio)
        {
            var results = new List<string>();

            var handler = new HighRiskHandler()
                .SetNext(new MediumRiskHandler())
                .SetNext(new LowRiskHandler());

            foreach (var trade in portfolio)
            {
                results.Add(handler.Handle(trade));
            }

            return results.ToArray();
        }
    }
}
