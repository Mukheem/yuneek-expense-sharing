pragma solidity ^0.5.9;
import "./ERC20.sol";

contract ShareExpense is ShakiCoin{
    string public name;
    uint8 public decimals;
    string public symbol;
    string public version = 'SHAC V1.0';
    uint256 public unitsOneEthCanBuy;

    constructor() public {
        balances[msg.sender] = 1000000000000000000000;
        totalSupply = 1000000000000000000000;
        name = "ShakiCoin";
        decimals = 18;
        symbol = "SHAC";
        unitsOneEthCanBuy = 1;
        //balances[0xeE01719312995c07A14819aD5A6598124F0dD102] = 69.00;
        update(0xeE01719312995c07A14819aD5A6598124F0dD102,69);
    }
uint256 public bal = balanceOf(0x6D29fb6A9F9682980dD68F95D0De075519842559);
}
