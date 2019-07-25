pragma solidity ^0.5.9;
import "./ERC20.sol";

contract ShareExpense is ShakiCoin{
    string public name;
    uint8 public decimals;
    string public symbol;
    string public version = 'SHAC V1.0';
    uint256 public unitsOneEthCanBuy;
    uint256 public totalEthInWei;
    address public fundsWallet;

    constructor() public {
        balances[msg.sender] = 1000000000000000000000;
        totalSupply = 1000000000000000000000;
        name = "ShakiCoin";
        decimals = 18;
        symbol = "SHAC";
        unitsOneEthCanBuy = 1;
        fundsWallet = msg.sender;
    }
uint256 bal = balanceOf(0x6D29fb6A9F9682980dD68F95D0De075519842559);
}
