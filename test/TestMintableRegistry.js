var RegistryFactory = artifacts.require('RegistryFactory');
var Registry = artifacts.require('Registry');

contract('Registry', accounts => {

  let factory = null;
  let registry = null;
  let _creator = accounts[0];

  beforeEach(async function () {
    // factory = await RegistryFactory.new({from: _creator});
    // await factory.createRegistry("Test Token", "TT", "A test token", 10);

    // Need to call the registry constructor directly.
    // TODO: Figure out how to call the factory creator and get the registry registry
    registry = await Registry.new("Test Token", "TT", "A test token", 10, _creator);
    await registry.Mint("test url 1", { from: _creator });
    await registry.Mint("test url 2", { from: _creator });
  });

  it('has a total supply equivalent to the inital supply', async function () {
    const maxSupply = await registry.maxSupply();
    assert.equal(maxSupply.toNumber(), 10);
  });

  it("should exist", function(done) {
    assert(registry.address != "0x0");
    done();
  });

  it("should start with default initial values", async function() {
      let _name = await registry.name();
      let _symbol = await registry.symbol();
      let _desc = await registry.description();
      let _ts = await registry.totalSupply();

      assert.equal(_name, "Test Token");
      assert.equal(_symbol, "TT");
      assert.equal(_desc, "A test token");
      assert.equal(_ts, 2);
  });

  it("should allow a token to be transfer after being allowed", async function() {
    let balance = await registry.balanceOf(accounts[1]);
    assert.equal(balance.toNumber(), 0);
    registry.approve(accounts[1], 0);
    registry.takeOwnership(0, {from: accounts[1]});
    balance = await registry.balanceOf(accounts[1]);
    assert.equal(balance.toNumber(), 1);
  });

  it("should allow a coin to be minted", async function() {
    let initialSupply = await registry.totalSupply();
    assert.equal(initialSupply.toNumber(), 2);
    await registry.Mint("test.url", {from: accounts[0]});
    let updatedSupply = await registry.totalSupply();
    assert.equal(updatedSupply.toNumber(), 3);
  })

  it("should approve many tokens at once", async function() {
    let balance = await registry.balanceOf(accounts[1]);
    assert.equal(balance.toNumber(), 0); // Was given 1 token earlier.
    await registry.approveMany(accounts[1], [0, 1]);
    await registry.takeOwnership(0, {from: accounts[1]});
    await registry.takeOwnership(1, {from: accounts[1]});
    balance = await registry.balanceOf(accounts[1]);
    assert.equal(balance.toNumber(), 2);
  })

  it("should approve all tokens at once", async function() {
    let balance = await registry.balanceOf(accounts[0]);
    assert.equal(balance.toNumber(), 2);
    await registry.approveAll(accounts[1], {from: accounts[0]});
    let tokens = await registry.tokensOf(accounts[0]);
    for (var t=0; t<tokens.length; t++) {
      await registry.takeOwnership(tokens[t].toNumber(), {from: accounts[1]});
    }
    let acc0_bal = await registry.balanceOf(accounts[0]);
    let acc1_bal = await registry.balanceOf(accounts[1]);
    assert.equal(acc0_bal.toNumber(), 0);
    assert.equal(acc1_bal.toNumber(), 2);
  })

  it("should allow account 0 to mint directly to account 1's addresss", async function() {
    let acc1_balance = await registry.balanceOf(accounts[1]);
    assert.equal(acc1_balance.toNumber(), 0);

    await registry.MintToAddress("test url", accounts[1]);
    acc1_balance = await registry.balanceOf(accounts[1]);
    assert.equal(acc1_balance.toNumber(), 1);
  })

});
