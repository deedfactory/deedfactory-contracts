pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract MintableRegistry is BaseRegistry {
  /* Contract template for a set of NFTs where the creator of the contract can
     mint additional tokens once the first set have been creater at the time of
     contract creation. */

  function MintableRegistry() public {
    creator = msg.sender;

    name = "Mintable Test Token";
    symbol = "MTT";
    description = "A mintable test token.";
    creator = msg.sender;

    for (uint256 t=0; t<10; t++) {
      _mint(msg.sender, t);
    }
  }

  function Mint(string url) public {
    require(msg.sender == creator);
    uint256 currentTokenCount = totalSupply();
    // The index of the newest token is at the # totalTokens.
    _mint(msg.sender, currentTokenCount);
    // _mint() call adds 1 to total tokens, but we want the token at index - 1
    tokenIdToMetadata[currentTokenCount] = url;
  }

}
