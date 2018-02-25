var RegistryFactory = artifacts.require("./RegistryFactory.sol");

module.exports = function(deployer) {
  deployer.deploy(RegistryFactory);
};
