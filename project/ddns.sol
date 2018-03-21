pragma solidity 0.4.21;

contract Owner{
    //event for withdraw amount from contract
    event WithdrawFromContract (address owner, uint value);
    
    address owner;
    
    //only owner midifier
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    function Owner() public{
        owner = msg.sender;
    }
    
    //function returns contract's balance
    function getBalance () public view onlyOwner returns(uint){
        return address(this).balance;
    }
    
    //withdraw function
    function withdraw () public onlyOwner{
        require (address(this).balance > 0);
        owner.transfer(address(this).balance);
        emit WithdrawFromContract(owner,address(this).balance);
    }
}

contract DDNS is Owner{
    
    event RegisterDomain (bytes domain, bytes4 ipAddress, uint expires, address domainOwner);
    event ChangeDomainIp (bytes domain, bytes4 oldIp, bytes4 newIp);
    event TransferDomain (bytes domain, address oldOwnew, address newOwner);
    
     //the domain is bytes, because string is UTF-8 encoded and we cannot get its length
    //the IP is bytes4 because it is more efficient in storing the sequence
    mapping (bytes => address) private domainOwner; //domain -- owner
    mapping (bytes => bytes4) private domainIP; // domain  -- ip
    //struct for receipt
    struct Receipt{ //recept
        uint amountPaidWei;
        uint timestamp;
        uint expires;
    }
    
    mapping (bytes => Receipt) private domainReceipt; // domain - recept(last for it)
    
    mapping (address => Receipt[]) private accountReceipts; // account - receipts 
    
    
    //moifier domain's owner access 
    modifier ownerAccess(bytes domain){
        require(domainOwner[domain] == msg.sender);
        _;
    }
    
    // domain contains more or equal than 5 symbols
    modifier domainNameCheck (bytes domain){
        require(domain.length>=5);
        _;
    }
    
    modifier domainPrice(bytes domain){
        require(msg.value >= getPrice(domain));
        _;
    }
    
    function register(bytes domain, bytes4 ip) public payable domainNameCheck(domain) domainPrice(domain) {
        uint payTime = now;
        uint expTime;
        Receipt memory newRecept;
        address sender = msg.sender;
        
        if(domainReceipt[domain].timestamp == 0 || domainReceipt[domain].expires < now ){
            domainOwner[domain] = sender;
            domainIP[domain] = ip;
            expTime = payTime+1 years;
            newRecept = Receipt({amountPaidWei:msg.value,timestamp:payTime,expires:expTime});
            domainReceipt[domain] = newRecept;
            accountReceipts[sender].push(newRecept);
        } else {
            require(sender == domainOwner[domain]);
            expTime = domainReceipt[domain].expires+1 years;
            newRecept = Receipt({amountPaidWei:msg.value,timestamp:payTime,expires:expTime});
            domainReceipt[domain] = newRecept;
            accountReceipts[sender].push(newRecept);
        }
        
        emit RegisterDomain(domain,ip,expTime,sender);
    }
    
    function () public payable{
        
    }
    
    function edit(bytes domain, bytes4 newIp) public ownerAccess(domain){
        emit ChangeDomainIp(domain,domainIP[domain],newIp);
        domainIP[domain] = newIp;
    }
    
    function transferDomain(bytes domain, address newOwner) public ownerAccess(domain) {
        emit TransferDomain (domain, domainOwner[domain],newOwner);
        domainOwner[domain] = newOwner;
        
    }
    
    function getIP(bytes domain) public view returns (bytes4) {
        return domainIP[domain];
    }
    
    function getPrice(bytes domain) public pure returns (uint) {
        for (uint i = 0; i<domain.length-2;i++){
            if (domain[i] == "s"){
                if (domain[i+1] == "e" && domain[i+2] == "x"){
                    return 1.5 ether;
                } 
            }
        }
        return 1 ether;
    }
    
    function getReceipts(address account) public view returns (uint[], uint[], uint[]) {
        
        uint len = accountReceipts[account].length;
        
        uint[] memory _amountPaidWei = new uint[](len);
        uint[] memory _timestamp = new uint[](len);
        uint[] memory _expires = new uint[](len);
        
        for (uint i = 0; i<len;i++){
            _amountPaidWei[i] = accountReceipts[account][i].amountPaidWei;
            _timestamp[i] = accountReceipts[account][i].timestamp;
            _expires[i] = accountReceipts[account][i].expires;
            
        }
        return (_amountPaidWei,_timestamp,_expires);
    }
}
