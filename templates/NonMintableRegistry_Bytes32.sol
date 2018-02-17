pragma solidity ^0.4.18;

import './BaseRegistry_bytes32.sol';

contract NonMintableRegistry is BaseRegistry {

  function NonMintableRegistry(
    string _name,
    string _symbol,
    string _description,
    uint256 _totalTokens,
    bytes32[] _urls) {
      require(_urls.length == _totalTokens);
      name = _name;
      symbol = _symbol;
      description = _description;
      totalTokens = _totalTokens;

      for (uint256 t=0; t < totalTokens; t++) {
        _mint(msg.sender, t);
        tokenIdToMetadata[t] = _urls[t];
      }


    }

}
