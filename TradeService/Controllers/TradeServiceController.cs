using Microsoft.AspNetCore.Mvc;
using System.Text.Json;
using TradeServiceLibrary.adapter;
using TradeServiceLibrary.interfaces;
using TradeServiceLibrary.model;

namespace TradeService.Controllers
{

    [ApiController]
    [Route("[controller]")]
    public class TradeServiceController : ControllerBase
    {
        private readonly ILogger<TradeServiceController> _logger;

        public TradeServiceController(ILogger<TradeServiceController> logger)
        {
            _logger = logger;
        }

        [HttpPost(Name = "CheckTradeRisk")]
        public IActionResult CheckTradeRisk([FromBody] List<ITrade> portfolio)
        {
            TradeAdapter tradeRiskAdapter = new TradeAdapter();

            return new JsonResult(
                tradeRiskAdapter.GetPortfolioAnalisys(portfolio),
                new JsonSerializerOptions { PropertyNamingPolicy = null }
            );
        }
    }
}
