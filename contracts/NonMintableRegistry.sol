pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract NonMintableRegistry is BaseRegistry {
  /* Contract template for a set of NFTs that are created at the time of the
     call, and no additional tokens can be minted. */

  function NonMintableRegistry() public {
    _name = "NonMintable Test Token";
    _symbol = "NMTT";
    _description = "A nonmintable test token.";

    for (uint256 t=0; t<10; t++) {
      _mint(msg.sender, t);
    }
  }
}
