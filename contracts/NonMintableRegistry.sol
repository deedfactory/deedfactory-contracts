pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract NonMintableRegistry is BaseRegistry {
  /* Contract template for a set of NFTs that are created at the time of the
     call, and no additional tokens can be minted. */

  function NonMintableRegistry() public {
    name = "NonMintable Test Token";
    symbol = "NMTT";
    description = "A nonmintable test token.";
    creator = msg.sender;

    for (uint256 t=0; t<10; t++) {
      _mint(msg.sender, t);
    }
  }
}
