pragma solidity ^0.4.20;

contract Owner{
    address owner;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function Owner() public{
        owner = msg.sender;
    }
    
    function getBalance () public view onlyOwner returns(uint){
        return this.balance;
    }
    
    function withdraw (uint amount) public onlyOwner{
        require (this.balance<= amount);
        owner.transfer(amount);
    }
}

contract DDNS is Owner{
    
    mapping (bytes => address) domainOwner;
    mapping (bytes => bytes4) domainIP;
    
    modifier ownerAccess(bytes domain){
        require(domainOwner[domain] == msg.sender);
        _;
    }
    
    
    struct Receipt{
        uint amountPaidWei;
        uint timestamp;
        uint expires;
    }
    
    //the domain is bytes, because string is UTF-8 encoded and we cannot get its length
    //the IP is bytes4 because it is more efficient in storing the sequence
    function register(bytes domain, bytes4 ip) public payable {
        
        
    }
    
    function () public payable{
        
    }
    
    function edit(bytes domain, bytes4 newIp) public ownerAccess(domain){
        
        domainIP[domain] = newIp;
        
    }
    
    function transferDomain(bytes domain, address newOwner) public {}
    
    function getIP(bytes domain) public view returns (bytes4) {
        require(domainIP[domain] != 0);
        return domainIP[domain];
    }
    
    function getPrice(bytes domain) public view returns (uint) {}
    
    // function getReceipts(address account) public view returns (Receipt[]) {}
}