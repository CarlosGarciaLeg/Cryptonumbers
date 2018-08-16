pragma solidity ^0.4.23;

import "./Ownable.sol";
import "./SafeMath.sol";

contract Cryptonumbers is Ownable {

  using SafeMath for uint256;

  event NewNumber(uint numberId, string name, uint hashNumber);

  uint hashDigits = 16;
  uint hashModulus = 10 ** hashDigits;

  struct Number {
    string name;
    uint hashNumber;
  }

  Number[] public numbers;

  mapping (uint => address) public numberToOwner;
  mapping (address => uint) ownerNumberCount;

  function _createNumber(string _name, uint _hashNumber) internal {
    uint id = numbers.push(Number(_name, _hashNumber)) - 1;
    numberToOwner[id] = msg.sender;
    ownerNumberCount[msg.sender] = ownerNumberCount[msg.sender].add(1);
    emit NewNumber(id, _name, _hashNumber);
  }

  function _generateRandomhashNumber(string _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % hashModulus;
  }

  function createRandomNumber(string _name) public {
    require(ownerNumberCount[msg.sender] == 0);
    uint randhash = _generateRandomhashNumber(_name);
    randhash = randhash - randhash % 100;
    _createNumber(_name, randhash);
  }

}


