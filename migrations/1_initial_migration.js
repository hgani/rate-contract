var Migrations = artifacts.require("./Migrations.sol");
const Rate = artifacts.require('Rate');

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Rate);
};
