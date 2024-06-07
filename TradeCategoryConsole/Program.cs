using System.Text;
using TradeServiceLibrary.adapter;
using TradeServiceLibrary.domain.models;
using TradeServiceLibrary.interfaces;

class Program
{
    private static string FormatNumber(double value) => string.Format("{0:N}", value);

    public static void Main()
    {
        #region Input Config

        var portfolio = new List<ITrade> {
            new Trade { Value = 2000000, ClientSector = "Private" },
            new Trade { Value = 400000, ClientSector = "Public" },
            new Trade { Value = 500000, ClientSector = "Public" },
            new Trade { Value = 3000000, ClientSector = "Public" },
            new Trade { Value = 1000000, ClientSector = "Public" },
            new Trade { Value = 1000000, ClientSector = "Private" }
        };

        #endregion

        #region Operation

        var tradeCategories = new TradeAdapter().GetTradeCategories(portfolio);

        #endregion

        #region Prepare Data for view

        List<string> output = new List<string>();

        output.Add("###### TRADE RISK ANALYSIS ######");
        output.Add("\n:: INPUT DATA ::");

        foreach (var trade in portfolio)
        {
            output.Add("Value: " + FormatNumber(trade.Value) + " - Sector: " + trade.ClientSector);
        }

        output.Add("\n:: RESULTS ::");

        output.Add(string.Join(", ", tradeCategories));

        output.Add("\n:: RESULTS (related) ::");

        foreach (var (result, index) in tradeCategories.Select((result, index) => (result, index)))
        {
            var trade = portfolio[index];

            output.Add("Value: " + FormatNumber(trade.Value) + " - Sector: " + trade.ClientSector + " >> " + result);
        }

        #endregion

        #region Console View

        foreach (var text in output)
        {
            Console.WriteLine(text);
        }

        #endregion
    }
}

