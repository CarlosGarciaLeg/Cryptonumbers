pragma solidity ^0.4.23;

import "./CreateCryptonumbers.sol";
import "./SafeMath.sol";
import "./ERC721.sol";

contract Cryptonumbers is ERC721, CreateCryptonumbers {

using SafeMath for uint256;

  mapping (uint => address) Approvals;

  modifier onlyOwnerOf(uint _tokenId) {
    require(msg.sender == tokenToOwner[_tokenId]);
    _;
  }

  function balanceOf(address _owner) public view returns (uint256 _balance) {
    return ownerNumberCount[_owner];
  }

  function ownerOf(uint256 _tokenId) public view returns (address _owner) {
    return tokenToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerNumberCount[_to] = ownerNumberCount[_to].add(1);
    ownerNumberCount[msg.sender] = ownerNumberCount[msg.sender].sub(1);
    tokenToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    _transfer(msg.sender, _to, _tokenId);
  }

  function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
    Approvals[_tokenId] = _to;
    emit Approval(msg.sender, _to, _tokenId);
  }

  function takeOwnership(uint256 _tokenId) public {
    require(Approvals[_tokenId] == msg.sender);
    address owner = ownerOf(_tokenId);
    _transfer(owner, msg.sender, _tokenId);
  }
}