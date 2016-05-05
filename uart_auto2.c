#include<stdio.h>

#define UART_REG_RB 0
#define UART_REG_TR 0
#define UART_REG_IE 1
#define UART_REG_II 2
#define UART_REG_FC 3
#define UART_REG_LC 4
#define UART_REG_MC 5
#define UART_REG_LS 6
#define UART_REG_MS 7
#define UART_REG_SR 8
#define UART_REG_DL1 0
#define UART_REG_DL2 1
//#define base ((0x5f0)<<20) 

typedef unsigned long uint32_t;

//--------------Function Declarations-----------------
void uart_putchar(char i);
void uart_init(uint32_t baud, char fifo_trig_level);
void setbaud(uint32_t baud);
int autobaud(void); 
char uart_getchar(void);

int main()
{
char rx_value;
int j=0;
uint32_t base;
uint32_t a = ((0x5f0));
base = (a<<20);

uart_init(115200,1);

//--------------------------UART HEAD-------------------------------
//--------------------UART HEAD-------------------------------------

uart_putchar('\r'); // d
for(j=0;j<8000;j++);

uart_putchar('S');//ASCII 74
for(j=0;j<8000;j++);

//------------------UART HEAD END----------------------

while (autobaud() == 2);

while(1)
{
//loop back
	while(!(0x01 & (*(volatile char *)((uint32_t)(base + UART_REG_LS)))));
	rx_value = (*(volatile char *)((uint32_t)(base + UART_REG_RB)));
	(*(volatile char *)((uint32_t)(base + UART_REG_TR))) = rx_value;
}

return 0;
}


void uart_init(uint32_t baud, char fifo_trig_level)
{
char baud_high,baud_low;
char fifo_level;

uint32_t a,base;
a = ((0x5f0));
base = (a<<20);


//Baud rate calculations

if(baud == 38400)
	{
	baud_high = 0;
	baud_low  = 162;
	}
else if(baud == 9600)
	{
	baud_high = 2;
	baud_low  = 139;
	}
else if(baud == 19200)
	{
	baud_high = 1;
	baud_low  = 69;
	}
else if(baud == 57600)
	{
	baud_high = 0;
	baud_low  = 108;
	}
else
	{
	baud_high = 0;
	baud_low  = 54;
	}
//--------------Baud --------------------------------

//--------------FIFO TRIGGER LEVEL-------------------
if(fifo_trig_level == 1)
{
	fifo_level = 0;	
}
else if(fifo_trig_level == 4)
{
	fifo_level = 64;	
}
else if(fifo_trig_level == 8)
{
	fifo_level = 128;	
}
else
{
	fifo_level = 192;	
}
//----------------FIFO-------------------------------


//---------------Initialization---------------------------

//--STEP1:LCR bit 7 zero disable access to divisor latch--
//--8bit data, 1 stop bit, no parity----------------------
(*(volatile char *)((uint32_t)(base + UART_REG_LC))) = 19;

//----------STEP2:Clear the Tx and Rx FIFO-----------
(*(volatile char *)((uint32_t)(base + UART_REG_FC))) = 198;

//----------STEP3:Tx buffer clear-----------------------
//(*(volatile char *)((uint32_t)(base + UART_REG_TR))) = 0;

//----------STEP4: Disabling all interrupt--------------
(*(volatile char *)((uint32_t)(base + UART_REG_IE))) = 0;

//----------STEP5: Setting BAUD RATE--------------------
//-----------Getting access to divisor latch------------
(*(volatile char *)((uint32_t)(base + UART_REG_LC))) = 147;

//--------MSB first--------------------------------------
(*(volatile char *)((uint32_t)(base + UART_REG_DL2))) = baud_high;
//--------LSB next---------------------------------------
(*(volatile char *)((uint32_t)(base + UART_REG_DL1))) = baud_low;

//-----------------Disable access to divisor latch------
(*(volatile char *)((uint32_t)(base + UART_REG_LC))) = 19;

//---------STEP6: Set FIFO trigger level----------------
(*(volatile char *)((uint32_t)(base + UART_REG_FC))) = fifo_level;

//--------Interrupt enable left------------------------

}

void uart_putchar(char i)
{
uint32_t base;
uint32_t a = ((0x5f0));
base = (a<<20);

//---------------Writing character to tx buffer----------
(*(volatile char *)((uint32_t)(base + UART_REG_TR))) = i;
}


char uart_getchar(void)
{
char rx_value;
uint32_t base;
uint32_t a = ((0x5f0));
base = (a<<20);

//---------------Getting character from Rx buffer----------
while(!(0x01 & (*(volatile char *)((uint32_t)(base + UART_REG_LS)))));
rx_value = (*(volatile char *)((uint32_t)(base + UART_REG_RB)));

return rx_value;
}



int autobaud(void)   
{   
    uint32_t rate;   	
	char rx;
	uint32_t base;
	uint32_t a = ((0x5f0));
	base = (a<<20);

	while(!(0x20 & (*(volatile char *)((uint32_t)(base + UART_REG_LS)))));// Check transmitter fifo is empty   
       
    setbaud(115200);   
       
	rx = uart_getchar();
	if(rx == 0x0d)
		rate = 115200;
	else if(rx == 0xe6)
		rate = 57600;	
	else if(rx == 0x1c)
		rate = 38400;	
	else if(rx == 0xe0)
		rate = 19200;	
	else if(rx == 0x80)
		rate = 14400;	
	else if(rx == 0x00)
	{
		setbaud(9600);
		rx = uart_getchar();
			if(rx == 0x0d)
				rate = 9600;
			else if(rx == 0xe6)
				rate = 4800;	
			else if(rx == 0x78)
				rate = 2400;	
			else if(rx == 0x80)
				rate = 1200;
			else
				return 2;
	}
	else
			return 2;
 
    setbaud(rate);   
   
      return 0;                                     // success   
}   


void setbaud(uint32_t baud)
{
char baud_high,baud_low;
char fifo_level;

uint32_t a,base;
a = ((0x5f0));
base = (a<<20);

//Baud rate Divisor Latch value calculations
if(baud == 1200)
	{
	baud_high = 20; //DL2
	baud_low  = 88; //DL1
	}
else if(baud == 2400)
	{
	baud_high = 10;
	baud_low  = 44;
	}
else if(baud == 4800)
	{
	baud_high = 5;
	baud_low  = 22;
	}
else if(baud == 9600)
	{
	baud_high = 2;
	baud_low  = 139;
	}
else if(baud == 14400)
	{
	baud_high = 1;
	baud_low  = 178;
	}
else if(baud == 19200)
	{
	baud_high = 1;
	baud_low  = 69;
	}
else if(baud == 38400)
	{
	baud_high = 0;
	baud_low  = 162;
	}
else if(baud == 57600)
	{
	baud_high = 0;
	baud_low  = 108;
	}
else //(baud == 115200)
	{
	baud_high = 0;
	baud_low  = 54;
	}

//----------STEP5: Setting BAUD RATE--------------------
//-----------Getting access to divisor latch------------
(*(volatile char *)((uint32_t)(base + UART_REG_LC))) = 147;

//--------MSB first--------------------------------------
(*(volatile char *)((uint32_t)(base + UART_REG_DL2))) = baud_high;
//--------LSB next---------------------------------------
(*(volatile char *)((uint32_t)(base + UART_REG_DL1))) = baud_low;

//-----------------Disable access to divisor latch------
(*(volatile char *)((uint32_t)(base + UART_REG_LC))) = 19;

}


