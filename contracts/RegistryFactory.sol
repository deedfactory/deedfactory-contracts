pragma solidity ^0.4.18;

import './MintableRegistry.sol';

contract RegistryFactory {

  function createRegistry(
    string _name,
    string _symbol,
    string _description,
    uint256 _initialSupply,
    bool _mintable) public returns (address) {

      MintableRegistry registry = new MintableRegistry(
          _name, _symbol, _description, _initialSupply, _mintable, msg.sender);
      return address(registry);
    }

}
