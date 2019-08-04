var ShakiCoin = artifacts.require("./ShareExpense.sol");

module.exports = function(deployer) {
  deployer.deploy(ShakiCoin);
};
