/*

    TODO LIST
    -Update contract
    -Track incoming REP by address
    -Distribute earnings
    -Add reporting capability
    -Add ability to retrieve earnings
    -Add enum results, maybe?
    -Users deposit REP
    -Approved withdraw REP
    -Approved withdraw rewards
    -Users withdraw rewards


    DONE
    -Users withdraw REP


    USE CASES
    -REP owner deposits REP
    -REP owner withdraws REP
    -REP owner withdraws owed tokens and ETH
    -Creator withdraws owed tokens and ETH
    -Creator approves address for reporting
    -Approved address reports
    -REP is received from Augur and distributed
    -Tokens and ETH is received from Augur and distributed

*/

//TODO include abstracts for code to be called, including basic token usage and augur

contract RepPool {

    //address for reporting contract
    Reporting public reporting;
    //address for REP token
    Rep public rep;
    //list of addresses approved to report.  Change name, as possibly confusing, when tokens need to add this contract's address as approved to accept the tokens
    address[] public approved;

    //tokens and eth owned by pool members
    mapping(address => uint) rep_owned;
    mapping(address => mapping(address => uint)) tokens_owned; //mapping of user address to tokens.  Second mapping is token address to amount of tokens.
    mapping(address => uint) eth_owned;

    //overflow is used when amount can't be evenly distributed between pool members
    mapping(address => uint) rep_overflow;
    mapping(address => mapping(address => uint)) tokens_overflow;
    mapping(address => uint) eth_overflow;

    //amount owned by approved - distributed as soon as it's deposited
    uint approved_rep;
    mapping(address => uint) approved_tokens
    uint approved_eth;

    //TODO figure out how to check if value is in array
    //TODO determine best practices for modifiers
    modifier Approved() {
        if(msg.sender is in approved) {
            _
        }
    }

    function RepPool(address augurAddress, address repAddress) {
        augur = Augur(augurAddress);
	rep = Rep(repAddress);
        approved.push(msg.sender);
    }

    //Must have "approved" contract to transfer Rep tokens
    //TODO check that transferFrom generates exception correctly if something goes wrong
    function depositRep(uint amount) {
        rep.transferFrom(msg.sender, this, amount);
        rep_owned[msg.sender] += amount;
    }

    //Complete
    function withdrawRep(uint amount) {
        if(rep_owned[msg.sender] >= amount){
            rep_owned[msg.sender] -= amount;
            rep.transfer(msg.sender, amount);
        }
    }

    function withdrawRewards() {
        //for each token
        if(tokens_owned[msg.sender][token] > 0){
	    uint amount = tokens_owned[msg.sender][token];
	    tokens_owned[msg.sender][token] = 0;
            token.transfer(msg.sender, amount);
	}
	//end for
	if(eth_owned[msg.sender] > 0){
	    //send eth to msg.sender
	}
    }

    function withdrawApproved() Approved {
        if(rep_approved > 0){
	    uint amount = rep_approved;
	    rep_approved = 0;
	    rep.transfer(msg.sender, amount);
        }
	//for each token
	if(tokens_approved[token] > 0){
	    uint amount = tokens_approved[token];
	    tokens_approved[token] = 0;
	    token.transfer(msg.sender, amount);
	}
	if(eth_approved > 0){
            //send eth to msg.sender
        }
    }
    
    function report() Approved {
        //if sender address is in approved address array
        //use Augur function to report result
    }

    function reveal() Approved {

    }
    
    function() {
        //used only when Augur sends Eth.  All else is considered donations.
	//I don't think the function needs to contain anything.
    }

    function updateTokenCount() {
        //distribute tokens and update count when tokens are sent by Augur.
	//Can't automatically read when tokens are sent, so have to do it on a timer.
	//Do it either at the time they are sent, or as soon after as is feasible, to keep people from trying to get rewards twice by depositing after getting their rewards.  Maybe save a snapshot of the distribution, and distribute that way?
    }
    
    function setAugurAddress(address newAugur) Approved {
            augur = Augur(newAugur);
    }
    
    function update() Approved{
    
    }

}
