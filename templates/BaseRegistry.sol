pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract BaseRegistry is ERC721Token {

  string name;
  string symbol;
  string description;
  // Total tokens starts at 0 because each new token must be minted and the
  // _mint() call adds 1 to totalTokens
  uint256 totalTokens = 0;

  // Metadata is a URL that points to a json dictionary
  mapping(uint256 => string) tokenIdToMetadata;

  public function assignUrlToToken(string _url, uint256 _tokenId) {
    require(msg.sender == ownerOf(_tokenId));

    tokenIdToMetadata[_tokenId] = _url;
  }

}
