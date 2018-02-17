pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract BaseRegistry is ERC721Token {

  string name;
  string symbol;
  string description;
  uint totalTokens;

  // Metadata is a URL that points to a json dictionary
  mapping(uint => bytes32) tokenIdToMetadata;

}
