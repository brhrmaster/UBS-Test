using TradeServiceLibrary.enums;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.model
{
    public class MediumRiskHandler : TradeHandlerBase
    {
        public override string Handle(ITrade request)
        {
            var actualRisk = RiskType.MEDIUMRISK.ToString();
            var currentSectorValue = SectorType.PUBLIC.ToString();
            var isValidSector = request.ClientSector.ToUpper() == currentSectorValue;
            var isValidValue = request.Value > 1000000;

            return Evaluate(isValidSector, isValidValue, actualRisk, request);
        }
    }
}
