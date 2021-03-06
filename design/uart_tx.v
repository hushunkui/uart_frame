module	uart_tx(
		input		wire				sclk				,
		input		wire				rst_n				,
		input		wire				po_flag			,
		input		wire[7:0]		po_data			,
		input		wire				tx_bit_flag	,
		input		wire[3:0]		tx_bit_cnt	,
		output	reg					tx_flag		,
		output	reg					tx				
);



//tx_flag定义，当po_flag为高时拉高，当数据传输完成后拉低
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx_flag	<=	0;
		else	if(po_flag==1)
				tx_flag	<=	1;
		else	if(tx_bit_flag==1&&tx_bit_cnt==9)		//使能信号在检测到rx起始位的时候拉高电平
				tx_flag	<=	0;									//当八位数据采集完成后拉低电平	
				
//rx
always@(posedge	sclk	or	negedge	rst_n)
		if(rst_n==0)
				tx	<=	1'b1	;
		else	if(tx_bit_flag==1)
				case(tx_bit_cnt)
								0:	tx	<=	1'b0			;
								1:	tx	<=	po_data[0];
								2:	tx	<=	po_data[1];
								3:	tx	<=	po_data[2];
								4:	tx	<=	po_data[3];
								5:	tx	<=	po_data[4];
								6:	tx	<=	po_data[5];
								7:	tx	<=	po_data[6];
								8:	tx	<=	po_data[7];
								9:	tx	<=	1'b1			;		
					default:  tx	<=	1'b1			;	
				endcase
				
endmodule
				                            
