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
//uint32_t a = ((0x5f0));

void uart_putchar(char);
void uart_init(uint32_t baud, char fifo_trig_level);


int main()
{

//char buff[10]="IISCDESE";

//char buff1[10]="12345";
int j=0;
uart_init(19200,1);
uart_putchar('\r'); // d
for(j=0;j<8000;j++);
uart_putchar('S');//ASCII 53
for(j=0;j<8000;j++);
uart_putchar('t');//ASCII 74
for(j=0;j<8000;j++);
uart_putchar('a');//ASCII 61
for(j=0;j<8000;j++);
uart_putchar('r');//ASCII 72
for(j=0;j<8000;j++);
uart_putchar('t');//ASCII 74
for(j=0;j<8000;j++);
uart_putchar(' ');//ASCII 20
for(j=0;j<8000;j++);
uart_putchar('\r');//ASCII d
for(j=0;j<8000;j++);
uart_putchar('\n');//ASCII d
for(j=0;j<8000;j++);


return 0;
}

void uart_init(uint32_t baud, char fifo_trig_level)
{
char baud_high,baud_low;
//uint32_t base = ((0x5f0)<<20);
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
else //(baud == 115200)
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
(*(volatile char *)((uint32_t)(base + UART_REG_TR))) = 0;

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

