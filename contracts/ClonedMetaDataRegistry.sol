pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract ClonedMetaDataRegistry is "_REGISTRY_" {
  /* Contract template for a set of NFTs that all have the same metadata
     attached to them. Using this method will save gas compared to the other
     calls because it doesn't require a followup transaction for each token
     to set the metadata. */

  public function ClonedMetaData() {
    name = "{_NAME_}";
    symbol = "{_SYMBOL_}";
    description = "{_DESC_}";

    for (uint256 t=0; t<"{_NUM_TOKENS_}"; t++) {
      _mint(msg.sender, t);
      tokenIdToMetadata[t] = "{_URL_}";
    }
  }
}
