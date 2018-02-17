pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract NonMintableRegistry is BaseRegistry {
  /* Contract template for a set of NFTs that are created at the time of the
     call, and no additional tokens can be minted. */ 

  public function NonMintableRegistry() {
      name = "{{ NAME }}";
      symbol = "{{ SYMBOL }}";
      description = "{{ DESC }}";

      for (uint256 t=0; t<"{{ NUM_TOKENS }}"; t++) {
        _mint(msg.sender, t);
      }
    }
  }
}
