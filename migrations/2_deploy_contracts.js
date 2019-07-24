var ShareExpense = artifacts.require("./ShareExpense.sol");

module.exports = function(deployer) {
  deployer.deploy(ShareExpense);
};
