pragma solidity ^0.4.18;

import 'zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol';

contract Registry is ERC721Token {

  string public name;
  string public symbol;
  string public description;
  uint256 maxTokens;
  uint256 currentSupply;
  address public creator;

  uint256 totalTokens = 0;

  // Mapping from token ID to owner
  mapping (uint256 => address) private tokenOwner;

  // Mapping from token ID to approved address
  mapping (uint256 => address) private tokenApprovals;

  // Mapping from owner to list of owned token IDs
  mapping (address => uint256[]) private ownedTokens;

  // Mapping from token ID to index of the owner tokens list
  mapping(uint256 => uint256) private ownedTokensIndex;

  function Registry(
    string _name,
    string _symbol,
    string _description,
    uint256 _maxTokens,
    address _caller) public {

      name = _name;
      symbol = _symbol;
      description = _description;
      maxTokens = _maxTokens;
      creator = _caller;

    }

  event MetadataAssigned(address indexed _owner, uint256 _tokenId, string _url);

  // Metadata is a URL that points to a json dictionary
  mapping(uint256 => string) tokenIdToMetadata;

  modifier isOwnedToken(uint256 _tokenId) {
    require(ownerOf(_tokenId) != address(0));
    _;
  }

  function assignDataToToken(uint256 _tokenId, string _url) public {
    require(msg.sender == creator);

    bytes memory tempEmptyStringTest = bytes(tokenIdToMetadata[_tokenId]);
    require(tempEmptyStringTest.length == 0);

    tokenIdToMetadata[_tokenId] = _url;
    MetadataAssigned(ownerOf(_tokenId), _tokenId, _url);
  }

  function getMetadataAtID(uint256 _tokenId) public view returns (string) {
    return tokenIdToMetadata[_tokenId];
  }

  function getCurrentSupply() public view returns (uint256) {
    return currentSupply;
  }

  function approveMany(address _to, uint256[] _tokenIds) public {
    /* Allows bulk-approval of many tokens. This function is useful for
       exchanges where users can make a single tx to enable the call of
       transferFrom for those tokens by an exchange contract. */
    for (uint256 i=0; i<_tokenIds.length; i++) {
      // approve handles the check for if one who is approving is the owner.
      approve(_to, _tokenIds[i]);
    }
  }

  function approveAll(address _to) public {
    uint256[] memory tokens = tokensOf(msg.sender);
    for (uint256 t=0; t < tokens.length; t++) {
      approve(_to, tokens[t]);
    }
  }

  function transferFrom(address _from, address _to, uint _tokenId) public isOwnedToken(_tokenId) {
    /* Implements the transferFrom definition as defined in ERC-20. transferFrom
    for an NFT further requires that the caller has been approved by the owner
    of the intended token beforehand.

    This use-case is especially useful in the case of an NFT exchange to limit
    the number of txs used since an owner can approve the exchange contract once
    for many tokens and the exchange can then call transferFrom for new txs
    instead of one approve and one transfer per tx. */
      require(approvedFor(_tokenId) == msg.sender);
      require(ownerOf(_tokenId) == _from);
      require(_to != address(0));

      clearApprovalAndTransfer(_from, _to, _tokenId);

      Approval(_from, 0, _tokenId);
      Transfer(_from, _to, _tokenId);
  }

  function Mint(string url) public {
    uint256 currentTokenCount = totalSupply();
    require(currentTokenCount.add(1) <= maxTokens);
    require(msg.sender == creator);

    // The index of the newest token is at the # totalTokens.
    _mint(msg.sender, currentTokenCount);
    // _mint() call adds 1 to total tokens, but we want the token at index - 1
    tokenIdToMetadata[currentTokenCount] = url;
  }

}
