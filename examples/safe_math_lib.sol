pragma solidity ^0.4.20;

library SafeMath {
    
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        //there is no case where this function can overflow/underflow
        uint256 c = a / b;
        return c;
    }
    
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    
    
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}


contract Owner {
    address public owner;
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function Owner () public{
        owner = msg.sender;
    }
    
    function changeOwner(address newOwner) public onlyOwner{
        owner = newOwner;
    }
}



contract counter is Owner {


    uint256 public state;
  
    uint256 lastChange = now;
    
    function changeState () public onlyOwner{
        state = SafeMath.add(state, now % 256);
        state = SafeMath.mul(state, SafeMath.sub(now, lastChange) );
        state = SafeMath.sub(state, block.gaslimit);
    }
    
}