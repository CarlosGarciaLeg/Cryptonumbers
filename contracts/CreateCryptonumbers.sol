pragma solidity ^0.4.23;

import "./Ownable.sol";
import "./SafeMath.sol";

contract CreateCryptonumbers is Ownable {

  using SafeMath for uint256;

  event NewNumber(uint numberId, uint naturalNumber, uint256 hashNumber, uint timeCreated);

  uint Digits = 18;
  uint Modulus = 10 ** Digits;

  struct Number {
    uint numberId;
    uint256 hashNumber;
    uint timeCreated;
  }

  Number[] public numbers;

  mapping (uint => address)  numberToOwner;
  mapping (address => uint) ownerNumberCount;
  mapping (uint => address) tokenToOwner;

  function _createNumber(uint _numberId, uint _hashNumber) internal {
    uint id = numbers.push(Number(_numberId, _hashNumber, now)) - 1;
    numberToOwner[id] = msg.sender;
    tokenToOwner[_numberId] = msg.sender;
    ownerNumberCount[msg.sender] = ownerNumberCount[msg.sender].add(1);
    emit NewNumber(id, _numberId, _hashNumber, now);
  }

  function _generateRandomhashNumber(uint _name) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_name.add(now))));
    return rand % Modulus;
  }

  function createRandomNumber(uint _name) public returns (uint){
    require(tokenToOwner[_name] == 0x0000000000000000000000000000000000000000);
    uint randhash = _generateRandomhashNumber(_name);
    randhash = randhash - randhash % 100;
    _createNumber(_name, randhash);
    return randhash;
  }
}                   

