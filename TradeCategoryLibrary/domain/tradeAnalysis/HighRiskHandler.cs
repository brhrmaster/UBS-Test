using TradeServiceLibrary.enums;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.domain.tradeAnalysis
{
    public class HighRiskHandler : TradeHandlerBase
    {
        public HighRiskHandler(): base(RiskType.HIGHRISK) { }

        public override string Handle(ITrade request)
        {
            var actualRisk = RiskType.ToString();
            var currentSectorValue = SectorType.PRIVATE.ToString();
            var isValidSector = request.ClientSector.ToUpper() == currentSectorValue;
            var isValidValue = request.Value > 1000000;

            return Evaluate(isValidSector, isValidValue, actualRisk, request);
        }
    }
}
