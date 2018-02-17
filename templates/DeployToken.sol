pragma solidity ^0.4.18;

import './NonMintableRegistry.sol';

contract DeployToken {

  NonMintableRegistry deployed;

  function DeployToken() {

    NonMintableRegistry nmr = (new NonMintableRegistry("Test", "TT", "Test Desc", 10));
    deployed = nmr;

  }

}
