using TradeServiceLibrary.enums;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.domain.tradeAnalysis
{
    public class HighRiskHandler : TradeHandlerBase
    {
        public override string Handle(ITrade request)
        {
            var actualRisk = RiskType.HIGHRISK.ToString();
            var currentSectorValue = SectorType.PRIVATE.ToString();
            var isValidSector = request.ClientSector.ToUpper() == currentSectorValue;
            var isValidValue = request.Value > 1000000;

            return Evaluate(isValidSector, isValidValue, actualRisk, request);
        }
    }
}
