var MintableRegistry = artifacts.require("./MintableRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(MintableRegistry);
};
