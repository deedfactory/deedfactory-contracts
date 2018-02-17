pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract BaseRegistry is ERC721Token {

  string internal _name;
  string internal _symbol;
  string internal _description;
  // Total tokens starts at 0 because each new token must be minted and the
  // _mint() call adds 1 to totalTokens
  uint256 totalTokens = 0;

  // Metadata is a URL that points to a json dictionary
  mapping(uint256 => string) tokenIdToMetadata;

  modifier isOwnedToken(uint256 _tokenId) {
    require(ownerOf(_tokenId) != address(0));
    _;
  }

  function name() public view returns (string) {
    return _name;
  }

  function symbol() public view returns (string) {
    return _symbol;
  }

  function description() public view returns (string) {
    return _description;
  }

  function assignUrlToToken(string _url, uint256 _tokenId) public {
    require(msg.sender == ownerOf(_tokenId));

    tokenIdToMetadata[_tokenId] = _url;
  }

  function approveMany(address _to, uint256[] _tokenIds) public {
    /* Allows bulk-approval of many tokens. This function is useful for
       exchanges where users can make a single tx to enable the call of
       transferFrom for many tokens by an exchange contract. */
    for (uint256 i; i<_tokenIds.length; i++) {
      // approve handles the check for if one who is approving is the owner.
      approve(_to, i);
    }
  }

  function transferFrom(address _from, address _to, uint _tokenId) public isOwnedToken(_tokenId) {
    /* Implements the transferFrom definition as defined in ERC-20. transferFrom
    for an NFT further requires that the caller has been approved by the owner
    of the intended token beforehand.

    This use-case is especially useful in the case of an NFT exchange to limit
    the number of txs used since an owner can approve the exchange contract once
    for many tokens and the exchange can call transferFrom. */
      require(approvedFor(_tokenId) == msg.sender);
      require(ownerOf(_tokenId) == _from);
      require(_to != address(0));

      clearApprovalAndTransfer(_from, _to, _tokenId);

      Approval(_from, 0, _tokenId);
      Transfer(_from, _to, _tokenId);
  }

}
