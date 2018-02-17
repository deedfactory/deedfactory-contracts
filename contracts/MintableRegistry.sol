pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract MintableRegistry is BaseRegistry {
  /* Contract template for a set of NFTs where the creator of the contract can
     mint additional tokens once the first set have been creater at the time of
     contract creation. */

  address creator;

  function MintableRegistry() public {
    creator = msg.sender;

    _name = "Mintable Test Token";
    _symbol = "MTT";
    _description = "A mintable test token.";

    for (uint256 t=0; t<10; t++) {
      _mint(msg.sender, t);
    }
  }

  function Mint(string url) public {
    require(msg.sender == creator);
    uint256 currentTokenCount = totalTokens;
    // The index of the newest token is at the # totalTokens.
    _mint(msg.sender, currentTokenCount);
    // _mint() call adds 1 to total tokens, but we want the token at index - 1
    tokenIdToMetadata[currentTokenCount] = url;
  }

}
