var NonMintableRegistry = artifacts.require("./NonMintableRegistry.sol");

module.exports = function(deployer) {
  deployer.deploy(NonMintableRegistry);
};
