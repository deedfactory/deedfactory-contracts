var MintableRegistry = artifacts.require('MintableRegistry');

contract('MintableRegistry', function(accounts) {

  it("should exist", function () {
    MintableRegistry.deployed().then(function(instance) {
      assert(instance.address != "0x0");
    })
  });

  it("should start with default initial values", function() {
    MintableRegistry.deployed().then(function(instance) {
      assert.equal(instance.name(), "Mintable Test Token");
      assert.equal(instance.symbol(), "MTT");
      assert.equal(instance.description(), "A mintable test token.");
      assert.equal(instance.totalSupply(), 10)
    })
  });

  it("should allow a token to be transfer after being allowed", function() {
    MintableRegistry.deployed().then(function(instance) {
      return instance;
    }).then(async function(instance) {
      let balance = await instance.balanceOf(accounts[1], 1);
      assert.equal(balance, 0);
      instance.approve(accounts[1], 1);
      instance.takeOwnership(1, {from: accounts[1]});
      balance = await instance.balanceOf(accounts[1], 1);
      assert.equal(balance, 1);
    })
  });

});
