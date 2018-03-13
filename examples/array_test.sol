pragma solidity ^0.4.20;

contract Proposal{
    
    address[] public owners;
    
    uint public nextToVote;
    
     struct ProposalAccept {
        uint value;
        address account;
        uint timeCreate;
    }
    
    ProposalAccept public aProposal;
    
    modifier onlyOwners{
        for (uint i = 0; i<= owners.length;i++){
            if (owners[i] == msg.sender){
                _;
                break;
            }
        }
    }
    
    function Proposal(address[] _owners) public{
        owners = _owners;
        nextToVote = 0;
    }
    
    function() public payable{
        
    }
    
    function createProposal(uint value, address receiver) public onlyOwners{
        require(aProposal.timeCreate + 5 minutes < now);
        
        aProposal = ProposalAccept({value:value,account:receiver,timeCreate:now});
        nextToVote = 0;
    }
    
    function vote() public{
        require (nextToVote<owners.length);
        require(owners[nextToVote]==msg.sender);
        require(now<aProposal.timeCreate+5 minutes);
        nextToVote ++;
        
        if(nextToVote>=owners.length){
            aProposal.account.transfer(aProposal.value);
        }
    }
    
}