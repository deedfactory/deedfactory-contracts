pragma solidity ^0.4.18;

import './Registry.sol';

contract RegistryFactory {
  address[] public created;

  function createRegistry(
    string _name,
    string _symbol,
    string _description,
    uint256 _maxSupply) public returns (address) {

      address registry = new Registry(
          _name, _symbol, _description, _maxSupply, msg.sender);
      created.push(registry);
      return registry;
    }

}
