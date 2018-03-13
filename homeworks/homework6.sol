pragma solidity ^0.4.20;

contract Crowdsale{
    
    mapping (address => uint) balances;
    
    address owner;
    
    mapping (address => bool) hadToken;
    
    address[] public tokenOwners;
    
    uint start;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    modifier crowdsalePeriod{
        require (now<=start+5 minutes);
        _;
    }
    
    modifier openPeriod{
        require(now>start+5 minutes);
        _;
    }
    
    function Crowdsale() public{
        owner = msg.sender;
        start = now;
    }
    
    function buyCrowdsalePeriod() public payable crowdsalePeriod{
        require(msg.value / 1 ether >0);
        require((msg.value / 1 ether) * 1 ether == msg.value);
        
        uint tokens = (msg.value/1 ether) * 5;
        
        balances[msg.sender] += tokens;
        updateTokenOwner(msg.sender);
    }
    
    function updateTokenOwner(address adr) internal{
        if (!hadToken[adr]){
            hadToken[adr] = true;
            tokenOwners.push(adr);
        }
    }
    
    function transferToken (uint token, address receiver) public openPeriod{
        require (balances[msg.sender]>=token);
        
        balances[msg.sender] -= token;
        balances[receiver] += token;
        
        updateTokenOwner(receiver);
    }
    
    function withdrawToken() public onlyOwner{
        require(now >= start+1 years);
        owner.transfer(this.balance);
    }
    
    function getAccountToken (address adr) public view returns(uint){
        return balances[adr];
    }
}