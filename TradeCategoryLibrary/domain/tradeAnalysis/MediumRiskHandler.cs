﻿using TradeServiceLibrary.enums;
using TradeServiceLibrary.interfaces;

namespace TradeServiceLibrary.domain.tradeAnalysis
{
    public class MediumRiskHandler : TradeHandlerBase
    {
        public MediumRiskHandler() : base(RiskType.MEDIUMRISK) { }

        public override string Handle(ITrade request)
        {
            var actualRisk = RiskType.ToString();
            var currentSectorValue = SectorType.PUBLIC.ToString();
            var isValidSector = request.ClientSector.ToUpper() == currentSectorValue;
            var isValidValue = request.Value > 1000000;

            return Evaluate(isValidSector, isValidValue, actualRisk, request);
        }
    }
}
