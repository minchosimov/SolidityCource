pragma solidity ^0.4.20;

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

contract SafeMath{
    function add (uint256 a, uint256 b) public pure returns(uint256){
        uint256 c = a+b;
        assert(c>=a);
        return c;
    }
    
    function mul (uint256 a, uint256 b) public pure returns(uint256){
        if (a==0 || b == 0){
            return 0;
        }
        
        uint256 c = a*b;
        assert(c/a == b);
        return c;
    }
    
    function div (uint256 a, uint256 b) public pure returns (uint256){
        uint256 c = a / b;
        assert(a == b * c + a % b); 
        return c;
    }
    
    function sub (uint256 a, uint256 b) public pure returns (uint256){
        assert (b<=a);
        return a - b;
    }
}

contract counter is Owner, SafeMath {
    uint256 public state;
    
    uint256 lastChange = now;
    
    function changeState () public onlyOwner{
        state = add(state,now%256);
        state = mul(state,sub(now,lastChange));
        state = sub(block.gaslimit,state);
        
        lastChange = now;
        
    }
    
}