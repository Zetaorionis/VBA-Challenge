Sub Chal2():

'Chanllenge 2 VBA

Dim ws As Worksheet

'Main Loop
For Each ws In Worksheets
    
    'Const statment advised and taught by Kourt Bailey during one on one tutoring
    Const FIRST_DATA_ROW As Integer = 2
    Const IN_TICKER_COL As Integer = 1
    Const OUT_TICKER_COL As Integer = 9
    Const IN_OPEN_PRICE As Integer = 3
    Const IN_CLOSE_PRICE As Integer = 6
    Const OUT_YEARLY_CHANGE As Integer = 10
    Const OUT_PERCENT_CHANGE As Integer = 11
    Const IN_VOLUME As Integer = 7
    Const OUT_TOTAL_STOCK_VOLUME As Integer = 12
    Const OUT_GREATEST_TICKER As Integer = 16
    Const OUT_GREATEST_VALUE As Integer = 17
    Const GREATEST_COL As Integer = 15
    
    
    Dim CurrentRow As Long
    Dim LastDataRow As Long
    Dim OutputRow As Long
    Dim CurrentTicker As String
    Dim NextTicker As String
    Dim OpenPrice As Variant
    Dim ClosePrice As Variant
    Dim YearlyChange As Variant
    Dim PercentChange As Variant
    Dim LastFormatRow As Long
    Dim CurrentVolume As Variant
    Dim PercentOpenPrice As Variant
    Dim PercentYearlyChange As Variant
    Dim NextVolume As Variant
    Dim TotalVolume As Variant
    Dim LastPercentRow As Long
    Dim LastVolumeRow As Variant
    
    ws.Cells(1, OUT_TICKER_COL).Value = "Ticker"
    ws.Cells(1, OUT_YEARLY_CHANGE).Value = "Yearly Change"
    ws.Cells(1, OUT_PERCENT_CHANGE).Value = "Percent Change"
    ws.Cells(1, OUT_TOTAL_STOCK_VOLUME).Value = "Total Stock Volume"
    ws.Cells(FIRST_DATA_ROW, GREATEST_COL).Value = "Greatest % Increase"
    ws.Cells(FIRST_DATA_ROW + 1, GREATEST_COL).Value = "Greatest % Decrease"
    ws.Cells(FIRST_DATA_ROW + 2, GREATEST_COL).Value = "Greatest Total Volume"
    ws.Cells(1, OUT_GREATEST_TICKER).Value = "Ticker"
    ws.Cells(1, OUT_GREATEST_VALUE).Value = "Value"
    

    LastDataRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    OutputRow = FIRST_DATA_ROW
    OpenPrice = ws.Cells(FIRST_DATA_ROW, IN_OPEN_PRICE).Value
    
    'Sub loop1
    For CurrentRow = FIRST_DATA_ROW To LastDataRow
        CurrentTicker = ws.Cells(CurrentRow, IN_TICKER_COL).Value
        NextTicker = ws.Cells(CurrentRow + 1, IN_TICKER_COL).Value
        If CurrentTicker <> NextTicker Then
                        
            'Input
            ClosePrice = ws.Cells(CurrentRow, IN_CLOSE_PRICE).Value
            CurrentVolume = ws.Cells(CurrentRow, IN_VOLUME).Value
            NextVolume = ws.Cells(CurrentRow + 1, IN_VOLUME).Value
            
            'Calculations
            YearlyChange = (ClosePrice - OpenPrice)
            PercentOpenPrice = (OpenPrice * 100)
            PercentYearlyChange = (YearlyChange * 100)
             If YearlyChange = 0 Then
                PercentChange = 0
             Else
                PercentChange = (PercentOpenPrice / PercentYearlyChange) * 0.1
             End If
            TotalVolume = (CurrentVolume + NextVolume)
            
            'Output
            ws.Cells(OutputRow, OUT_TICKER_COL).Value = CurrentTicker
            ws.Cells(OutputRow, OUT_YEARLY_CHANGE).Value = YearlyChange
            ws.Cells(OutputRow, OUT_PERCENT_CHANGE).Value = PercentChange
             ws.Cells(OutputRow, OUT_PERCENT_CHANGE).NumberFormat = "0.00%"
             ws.Cells(OutputRow, OUT_TOTAL_STOCK_VOLUME).Value = TotalVolume
             
            ' Prepare for next stock
            OutputRow = OutputRow + 1
            
        End If
        
    'End Sub loop1
    Next CurrentRow
    
    'Start Sub loop2
    'Formatting
    LastFormatRow = ws.Cells(Rows.Count, OUT_YEARLY_CHANGE).End(xlUp).Row
    
    For CurrentRow = FIRST_DATA_ROW To LastFormatRow
    
          If ws.Cells(CurrentRow, OUT_YEARLY_CHANGE).Value > 0 Then
             ws.Cells(CurrentRow, OUT_YEARLY_CHANGE).Interior.ColorIndex = 10
                   
          Else
             ws.Cells(CurrentRow, OUT_YEARLY_CHANGE).Interior.ColorIndex = 3
          End If
          
     'End Sub loop2
     Next CurrentRow
     
     'Start Sup loop3
     'Min % Function and Print
     LastPercentRow = ws.Cells(Rows.Count, OUT_PERCENT_CHANGE).End(xlUp).Row
    
    'Max % Function and Print
     For CurrentRow = FIRST_DATA_ROW To LastPercentRow
        If ws.Cells(CurrentRow, OUT_PERCENT_CHANGE) = Application.WorksheetFunction.Max(ws.Range("K2:K" & LastPercentRow)) Then
           ws.Cells(FIRST_DATA_ROW, OUT_GREATEST_TICKER).Value = ws.Cells(CurrentRow, OUT_TICKER_COL).Value
           ws.Cells(FIRST_DATA_ROW, OUT_GREATEST_VALUE).Value = ws.Cells(CurrentRow, OUT_PERCENT_CHANGE).Value
            
            'Format to %
            ws.Cells(FIRST_DATA_ROW, OUT_GREATEST_VALUE).NumberFormat = "0.00%"
         End If
         
          'Min % Function and Print
         If ws.Cells(CurrentRow, OUT_PERCENT_CHANGE) = Application.WorksheetFunction.Min(ws.Range("K2:K" & LastPercentRow)) Then
            ws.Cells(FIRST_DATA_ROW + 1, OUT_GREATEST_TICKER).Value = ws.Cells(CurrentRow, OUT_TICKER_COL).Value
            ws.Cells(FIRST_DATA_ROW + 1, OUT_GREATEST_VALUE).Value = ws.Cells(CurrentRow, OUT_PERCENT_CHANGE).Value
            
             'Format to %
             ws.Cells(FIRST_DATA_ROW + 1, OUT_GREATEST_VALUE).NumberFormat = "0.00%"
            
          End If
     'End Sub loop3
     Next CurrentRow
      
    'Start Sub loop4
    'Max Volume and Print
     LastVolumeRow = ws.Cells(Rows.Count, OUT_TOTAL_STOCK_VOLUME).End(xlUp).Row
     
     For CurrentRow = FIRST_DATA_ROW To LastVolumeRow
        If ws.Cells(CurrentRow, OUT_TOTAL_STOCK_VOLUME) = Application.WorksheetFunction.Max(ws.Range("L2:L" & LastVolumeRow)) Then
           ws.Cells(FIRST_DATA_ROW + 2, OUT_GREATEST_TICKER).Value = ws.Cells(CurrentRow, OUT_TICKER_COL).Value
           ws.Cells(FIRST_DATA_ROW + 2, OUT_GREATEST_VALUE).Value = ws.Cells(CurrentRow, OUT_TOTAL_STOCK_VOLUME).Value
           
        End If
     'End Sub loop4
     Next CurrentRow
 'End Main loop
 Next ws
End Sub



