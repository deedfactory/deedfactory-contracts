pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract NonMintableRegistry is BaseRegistry {

  public function NonMintableRegistry() {
      name = "{_NAME_}";
      symbol = "{_SYMBOL_}";
      description = "{_DESC_}";

      for (uint256 t=0; t<"_NUM_TOKENS_"; t++) {
        _mint(msg.sender, t);
      }
    }

}
