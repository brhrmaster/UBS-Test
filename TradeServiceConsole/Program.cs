using TradeServiceLibrary.adapter;
using TradeServiceLibrary.domain.models;
using TradeServiceLibrary.interfaces;

class Program
{
    public static void Main()
    {
        Console.WriteLine("###### TRADE RISK ANALYSIS ######");

        // input configuration
        var portfolio = new List<ITrade> {
            new Trade { Value = 2000000, ClientSector = "Private" },
            new Trade { Value = 400000, ClientSector = "Public" },
            new Trade { Value = 500000, ClientSector = "Public" },
            new Trade { Value = 3000000, ClientSector = "Public" },
            new Trade { Value = 1000000, ClientSector = "Public" },
            new Trade { Value = 1000000, ClientSector = "Private" }
        };

        Console.WriteLine("\n:: INPUT DATA ::");

        foreach (var trade in portfolio)
        {
            Console.WriteLine("Value: {0:C} - Sector: {1}", trade.Value, trade.ClientSector);
        }

        var analysisResults = new TradeAdapter().GetPortfolioAnalysis(portfolio);

        Console.WriteLine("\n:: RESULTS ::");

        foreach (var (result, index) in analysisResults.Select((result, index) => (result, index)))
        {
            var currentTrade = portfolio[index];
            Console.WriteLine("Value: {0:C} - Sector: {1} >> {2}", currentTrade.Value, currentTrade.ClientSector, result);
        }
    }
}

