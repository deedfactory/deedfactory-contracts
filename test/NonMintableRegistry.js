var NonMintableRegistry = artifacts.require('./NonMintableRegistry.sol');

contract('NonMintableRegistry', function(accounts) {
  var registryInstance;

  it("should exist", function() {
    return NonMintableRegistry.deployed("Test", "TT", "Test Desc", 10).then(function(instance) {
      assert(instance);
      return instance;
    });
  })
});
