// *************************************************************************************************
//
// Actual revision: $Revision: $
// Revision label:  $Name: $
// Revision state:  $State: $
//
// *************************************************************************************************
// Radio core access functions. Taken from TI reference code for CC430.
// *************************************************************************************************

// *************************************************************************************************
// Prototype section
uint8_t Strobe(uint8_t strobe);
uint8_t ReadSingleReg(uint8_t addr);
void WriteSingleReg(uint8_t addr, uint8_t value);
void ReadBurstReg(uint8_t addr, uint8_t *buffer, uint8_t count);
void WriteBurstReg(uint8_t addr, uint8_t *buffer, uint8_t count);
void ResetRadioCore(void);
void WritePATable(uint8_t value);
void WaitForXT2(void);
void Transmit(uint8_t *buffer, uint8_t length);
