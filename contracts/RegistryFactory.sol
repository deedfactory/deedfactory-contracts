pragma solidity ^0.4.18;

import './Registry.sol';

contract RegistryFactory {
  address[] public created;

  function createRegistry(
    string _name,
    string _symbol,
    string _description,
    uint256 _initialSupply) public returns (address) {

      address registry = new Registry(
          _name, _symbol, _description, _initialSupply, msg.sender);
      created.push(registry);
      return address(registry);
    }

  function getLastCreated() public view returns (address) {
      require(created.length > 0);
      return created[created.length - 1];
  }

}
