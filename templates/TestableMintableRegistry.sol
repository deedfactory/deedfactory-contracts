pragma solidity ^0.4.18;

import './MintableRegistry.sol';

contract TestableMintableRegistry is MintableRegistry {
  /* Contract template for a set of NFTs where the creator of the contract can
     mint additional tokens once the first set have been creater at the time of
     contract creation. */

  address creator;

  function TestableMintableRegistry() public {
    creator = msg.sender;

    name = "TestToken";
    symbol = "TT";
    description = "This token is for testing mintable registry.";

    for (uint256 t=0; t<10; t++) {
      _mint(msg.sender, t);
    }
  }

}
