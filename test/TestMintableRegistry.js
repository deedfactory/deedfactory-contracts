var RegistryFactory = artifacts.require('RegistryFactory');
var Registry = artifacts.require('Registry');

contract('RegistryFactory', function(accounts) {

  var registry;

  before(function (done) {
    const factory = await RegistryFactory.new();

  });

  it("should exist and can create a registry", function(done) {
    RegistryFactory.deployed().then(async function(instance) {
      assert(instance.address != "0x0");
      // registry = await instance.createRegistry(
      //   "Mintable Test Token", "MTT", "A mintable test token.", 10, true);
      // assert(registry.address != "0x0");
      done();
    })
  });

  it("should start with default initial values", async function(done) {
      let _name = registry.name();
      let _symbol = registry.symbol();
      let _desc = registry.description();
      let _ts = registry.totalSupply();

      assert.equal(_name, "Mintable Test Token");
      assert.equal(_symbol, "MTT");
      assert.equal(_desc, "A mintable test token.");
      assert.equal(_ts, 10);
      done();
  });

  it("should allow a token to be transfer after being allowed", function(done) {
    MintableRegistry.deployed().then(async function(instance) {
      let balance = await instance.balanceOf(accounts[1]);
      assert.equal(balance.toNumber(), 0);
      instance.approve(accounts[1], 0);
      instance.takeOwnership(0, {from: accounts[1]});
      balance = await instance.balanceOf(accounts[1]);
      assert.equal(balance.toNumber(), 1);
      done();
    })
  });

  it("should allow a coin to be minted", function(done) {
    MintableRegistry.deployed().then(async function(instance) {
      let initialSupply = await instance.totalSupply();
      assert.equal(initialSupply, 10);
      await instance.Mint("test.url", {from: accounts[0]});
      let updatedSupply = await instance.totalSupply();
      assert.equal(updatedSupply, 11);
      done();
    })
  })

  it("should approve many tokens at once", function(done) {
    MintableRegistry.deployed().then(async function(instance) {
      let balance = await instance.balanceOf(accounts[1]);
      assert.equal(balance.toNumber(), 1); // Was given 1 token earlier.
      await instance.approveMany(accounts[1], [1, 2]);
      await instance.takeOwnership(1, {from: accounts[1]});
      await instance.takeOwnership(2, {from: accounts[1]});
      balance = await instance.balanceOf(accounts[1]);
      assert.equal(balance.toNumber(), 3);
      done();
    })
  })

  it("should approve all tokens at once", function(done) {
    MintableRegistry.deployed().then(async function(instance) {
      let balance = await instance.balanceOf(accounts[1]);
      assert.equal(balance.toNumber(), 3);
      await instance.approveAll(accounts[1], {from: accounts[0]});
      let tokens = await instance.tokensOf(accounts[0]);
      for (var t=0; t<tokens.length; t++) {
        await instance.takeOwnership(tokens[t].toNumber(), {from: accounts[1]});
      }
      let acc0_bal = await instance.balanceOf(accounts[0]);
      let acc1_bal = await instance.balanceOf(accounts[1]);
      assert.equal(acc0_bal.toNumber(), 0);
      assert.equal(acc1_bal.toNumber(), 11);
      done();
    })
  })

  it("should allow a URL to be assigned", function(done) {
    MintableRegistry.deployed().then(async function(instance) {
      let url_5 = await instance.getMetadataAtID(5);
      assert.equal(url_5, '');
      let urlPass = "new url";
      await instance.assignDataToToken(5, urlPass);
      url_5 = await instance.getMetadataAtID(5);
      assert.equal(url_5, "new url");
      done();
    })
  })

});
