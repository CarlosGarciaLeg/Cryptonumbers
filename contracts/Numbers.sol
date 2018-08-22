pragma solidity ^0.4.24;

import "./Ownable.sol";
import "./StandardToken.sol";

contract Numbers is Ownable, StandardToken {


    string public name = "Numbers";
    string public symbol = "NUM";
    uint public decimals = 18;

    uint public totalSupply = 100 * (10**6) * (10**18);  

    constructor () public {
        balances[msg.sender] = 100 * (10**6) * (10**18);  //Public
    }

    function () public {
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        balances[_newOwner] = balances[owner].add(balances[_newOwner]);
        balances[owner] = 0;
        Ownable.transferOwnership(_newOwner);
    }

    function transferAnyERC20Token(address tokenAddress, uint amount) public onlyOwner returns (bool success) {
        return ERC20(tokenAddress).transfer(owner, amount);
    }
}