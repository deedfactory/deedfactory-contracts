pragma solidity ^0.4.18;

import './BaseRegistry.sol';

contract NonMintableRegistry is BaseRegistry {

  public function NonMintableRegistry() {
      name = "{{ NAME }}";
      symbol = "{{ SYMBOL }}";
      description = "{{ DESC }}";

      for (uint256 t=0; t<"{{ NUM_TOKENS }}"; t++) {
        _mint(msg.sender, t);
      }
    }

}
