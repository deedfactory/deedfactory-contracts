pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract ClonedMetaDataRegistry is BaseRegistry {
  /* Contract template for a set of NFTs that all have the same metadata
     attached to them. Using this method will save gas compared to the other
     calls because it doesn't require a followup transaction for each token
     to set the meta*/

  function ClonedMetaData() public {
    _name = "Clone test token";
    _symbol = "CTT";
    _description = "A test token where each token has the same metadata.";

    for (uint256 t=0; t<10; t++) {
      _mint(msg.sender, t);
      tokenIdToMetadata[t] = "{_URL_}";
    }
  }
}
