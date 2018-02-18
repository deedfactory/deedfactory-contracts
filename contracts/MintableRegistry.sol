pragma solidity ^0.4.18;

import './Registry.sol';

contract MintableRegistry is Registry {

  function MintableRegistry(
    string _name,
    string _symbol,
    string _description,
    uint256 _initialSupply,
    bool _mintable,
    address _caller) public {

      name = _name;
      symbol = _symbol;
      description = _description;
      mintable = _mintable;
      creator = _caller;
      totalTokens = 0;

      for (uint256 t=0; t<_initialSupply; t++) {
        _mint(creator, t);
      }
    }

}
