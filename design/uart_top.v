module		uart_top(
		input		wire				sclk		,
		input		wire				rst_n		, 
		input		wire				rx      ,
		output	wire				tx				//tx并行八位数据
);

wire					rx_bit_flag		;//to		U2 
wire[3:0]			rx_bit_cnt		;//to  	U2
wire					tx_bit_flag		;//to		U3 
wire[3:0]			tx_bit_cnt	  ;//to 	U3
wire[7:0]			po_data				;//to		U4  
wire					rx_flag				;//to 	U1
wire[7:0]			tx_data				;
wire			tx_flag1				;//to 	U3
//bps例化
uart_bps_rx	U1(
.sclk					(sclk				),//from top
.rst_n				(rst_n			),//from top
.rx_flag			(rx_flag		),//from U2
.tx_flag			(tx_flag		),//from U3
.rx_bit_flag	(rx_bit_flag),//to	U2
.rx_bit_cnt		(rx_bit_cnt	),//to  U2
.tx_bit_flag	(tx_bit_flag),//to	U3
.tx_bit_cnt	  (tx_bit_cnt	) //to  U3
);

//rx例化
uart_rx	U2(
.sclk				(sclk				),//from	top
.rst_n			(rst_n			),//from	top
.rx					(rx					),//from	top
.rx_bit_cnt	(rx_bit_cnt	),//from	U1
.rx_bit_flag(rx_bit_flag),//from	U1
.po_data		(po_data		),//to		U3	 
.rx_flag		(rx_flag		),//to 		U1
.po_flag		(po_flag		)	//to 		U4
	
);

//tx例化
uart_tx	U3(
.sclk				(sclk				),//from	top 
.rst_n			(rst_n			),//from	top 
.po_flag		(tx_flag1		),//from	U4 
.po_data		(tx_data		),//from	U4   
.tx_bit_flag(tx_bit_flag),//from	U1  
.tx_bit_cnt	(tx_bit_cnt	),//from	U1	
.tx_flag		(tx_flag		),//from	U1
.tx					(tx					)	//to 		top  	
);           

//frame例化               
fram_ctrl	U4(
.sclk			(sclk		),//from	top 
.rst_n		(rst_n	),//from	top 
.rx_data	(po_data),//from  U2  
.rx_flag	(po_flag),//from  U2  
.tx_data	(tx_data),//to	U1  
.tx_flag1	(tx_flag1) //to	U3	
                   
);                 
endmodule