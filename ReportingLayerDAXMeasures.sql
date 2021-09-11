--DataSet Measures & their DAX functions
--Brokerage Profit
--Older Measures
AvgProfitPerLoad = SUM('dbo.ReportingTable'[ACC_BrokerageProfit]) / COUNT('dbo.ReportingTable'[LD_PONumber])

Rank = rankx(all('dbo.ReportingTable'[Broker]),calculate(sum('dbo.ReportingTable'[ACC_BrokerageProfit]))) 
--Total
SalesProfit_T = SUM('dbo.ReportingTable'[ACC_BrokerageProfit])
SalesProfit_T_1 = IF ( ISBLANK( [SalesProfit_T]),0,[SalesProfit_T])
SalesProfit_T_Avg = AVERAGE('dbo.ReportingTable'[ACC_BrokerageProfit])
SalesProfit_T_Avg_1 = IF ( ISBLANK( [SalesProfit_T_Avg]),0,[SalesProfit_T_Avg])
SalesProfit_T_Margin = DIVIDE([SalesProfit_T_1],sum('dbo.ReportingTable'[ACC_Revenue]))		
SalesProfit_T_PerLoad = DIVIDE([SalesProfit_T_1],COUNT('dbo.ReportingTable'[LD_PONumber]))
SalesProfit_RatioBR = DIVIDE([SalesProfit_T_1], [BRate_T])
SalesProfit_RatioTC = DIVIDE([SalesProfit_T_1], [TCost_T])
--Calendar Year
SalesProfit_CY = CALCULATE('ReportingLayer Measures'[SalesProfit_T],FILTER('powerbi ReportingCalendar','powerbi ReportingCalendar'[Year]=YEAR(Today())))
SalesProfit_CY_1 = IF(ISBLANK([SalesProfit_CY]),0,[SalesProfit_CY])
SalesProfit_CY_Countdown = MAX('dbo.ReportingTable'[B_CY_SalesGoal]) - [SalesProfit_CY-1]
SalesProfit_CY_Percent = DIVIDE([SalesProfit_CY_1],MAX('dbo.ReportingTable'[B_CY_SalesGoal]))
SalesProfit_CY_Percent_1 = IF(ISBLANK([SalesProfit_CY_Percent]),0,[SalesProfit_CY_Percent])
SalesProfit_CY_Avg = CALCULATE(SUM('dbo.ReportingTable'[ACC_BrokerageProfit])FILTER('powerbi ReportingCalendar','powerbi ReportingCalendar'[Year]=YEAR(Today())))
SalesProfit_CY_Avg_1 = IF ( ISBLANK( [SalesProfit_CY_Avg]),0,[SalesProfit_CY_Avg])
--This Week
SalesProfit_WK = CALCULATE('ReportingLayer Measures'[SalesProfit_T],FILTER('powerbi ReportingCalendar','powerbi ReportingCalendar'[WeekOfYear]=WEEKNUM(Today())),FILTER('powerbi ReportingCalendar','powerbi ReportingCalendar'[Year]=YEAR(Today())))
SalesProfit_WK_1 = IF(ISBLANK([SalesProfit_WK]),0,[SalesProfit_WK])
SalesProfit_WK_Countdown = MAX('dbo.ReportingTable'[B_W_SalesGoal]) - [SalesProfit_WK_1]
SalesProfit_WK_Percent = DIVIDE([SalesProfit_WK_1],MAX('dbo.ReportingTable'[B_W_SalesGoal]))
SalesProfit_WK_Percent_1 = IF(ISBLANK([SalesProfit_WK_Percent]),0,[SalesProfit_WK_Percent])
SalesProfit_WK_Avg = CALCULATE(SUM('dbo.ReportingTable'[ACC_BrokerageProfit]),FILTER('powerbi ReportingCalendar','powerbi ReportingCalendar'[WeekOfYear]=WEEKNUM(Today())),FILTER('powerbi ReportingCalendar','powerbi ReportingCalendar'[Year]=YEAR(Today())))
SalesProfit_WK_Avg_1 = IF ( ISBLANK( [SalesProfit_WK_Avg]),0,[SalesProfit_WK_Avg])
--Truck Cost	
TCost_T = SUM('dbo.ReportingTable'[ACC_TruckCost])
--Bill Rate 
BRate_T = SUM('dbo.ReportingTable'[ACC_BillRate])
--Customer
CProfit_T_Rank = RANKX( ALL ( 'dbo.ReportingTable'[Cust_Name]), 'ReportingLayer Measures'[SalesProfit_T])
--Broker
--Total
B_SalesProfit_T_Rank = RANKX( ALL ( 'dbo.ReportingTable'[Broker]), 'ReportingLayer Measures'[SalesProfit_T_1])
--Calendar Year
B_SalesProfit_CY_Rank = RANKX( ALL ( 'dbo.ReportingTable'[Broker]), 'ReportingLayer Measures'[SalesProfit_CY_1])
B_SalesProfit_CY_GoalCountdown = 'dbo.ReportingTable'[B_CY_SalesGoal] - 'ReportingLayer Measures'[SalesProfit_CY_1]
B_SalesProfit_CY_GoalPercent = DIVIDE('ReportingLayer Measures'[SalesProfit_CY_1],'ReportingLayer Measures'[B_CY_SalesGoal])
--This Week
B_SalesProfit_WK_Rank = RANKX( ALL ( 'dbo.ReportingTable'[Broker]), 'ReportingLayer Measures'[SalesProfit_WK_1])
B_SalesProfit_WK_GoalCountdown = 'dbo.ReportingTable'[B_W_SalesGoal] - 'ReportingLayer Measures'[SalesProfit_WK_1]
B_SalesProfit_WK_GoalPercent = DIVIDE('ReportingLayer Measures'[SalesProfit_WK_1]',dbo.ReportingTable'[B_W_SalesGoal])
--Dates & Times
B_Years = //TODO
B_Months = //TODO
G_FirstLoad = MIN('dbo.ReportingTableV1'[LD_LoadDate])
G_LastLoad = MAX('dbo.ReportingTableV1'[LD_LoadDate])