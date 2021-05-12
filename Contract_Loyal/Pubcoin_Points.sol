pragma solidity >=0.5.8;

import "./Pubcoin.sol";
import './Ownable.sol';
import './PointsTokenStorage.sol';

interface ILoyaltyPoints {
   function initialize(address newAdministrator) external;
}

contract pubcoin_points is PointsTokenStorage, Ownable, ILoyaltyPoints {
    //address private owner;
    
	pubcoin pp;
	
	modifier newUser(address account) {
        //check account in existing members
        require(!members[account].isRegistered, "Account already registered as Member.");

        //check account in existing partners
        require(!partners[account].isRegistered, "Account already registered as Partner.");
        _;
    }

    modifier isMember(address account) {
        // only member can call
        require(members[account].isRegistered, "Sender not registered as Member.");
        _;
    }

    modifier isPartners(address account) {
        // verify partner address
        require(partners[account].isRegistered, "Partner address not found.");
        _;
    }

    modifier hasPoints(address member, uint _points) {
        // verify enough points for member
        require(members[member].points >= _points, "Insufficient points.");
        _;
    }
    
    function initialized() public view returns (bool) {
        return boolStorage[keccak256('loyalty_points_initialized')];
    }

    function initialize(address newAdministrator) public {
        require(!initialized(), 'Initialization already executed.');
        setOwner(newAdministrator);
        boolStorage[keccak256('loyalty_points_initialized')] = true;
        uintStorage[keccak256('loyalty_score_timespan')] = 0;
    }

    function setScoreTimespan(uint256 scoreTimespan) public {
        uintStorage[keccak256('loyalty_score_timespan')] = scoreTimespan;
    }

    function getScoreTimespan() public view returns(uint256) {
        return uintStorage[keccak256('loyalty_score_timespan')];
    }

    // function registerMember () public {
    //     registerMember(msg.sender);
    // }

    //register sender as member
    function registerMember (address member) public newUser(member) {
        //add member account
        members[member] = Member(member, 0, true);
    }

    function registerPartner (address partner) public onlyOwner newUser(partner)  {
        //add partner account
        partners[partner] = Partner(partner, true);

        //add partners info to be shared with members
        partnersInfo.push(Partner(partner, true));
    }

    //update member with points earned
    function earnPoints (uint _points, address _memberAddress, address _partnerAddress) public
        onlyOwner
        isMember(_memberAddress)
        isPartners(_partnerAddress)
    {
        // update member account
        members[_memberAddress].points = members[_memberAddress].points + _points;

        // add transction
        transactionsInfo.push(PointsTransaction({
            points: _points,
            timestamp: block.timestamp,
            transactionType: TransactionType.Earned,
            memberAddress: members[_memberAddress].memberAddress,
            partnerAddress: _partnerAddress
        }));

    }

    //update member with points used
    function usePoints (uint _points, address _memberAddress, address _partnerAddress) public
        onlyOwner
        isMember(_memberAddress)
        isPartners(_partnerAddress)
        hasPoints(_memberAddress, _points)
    {
        // update member account
        members[_memberAddress].points = members[_memberAddress].points - _points;

        // add transction
        transactionsInfo.push(PointsTransaction({
            points: _points,
            timestamp: block.timestamp,
            transactionType: TransactionType.Redeemed,
            memberAddress: members[_memberAddress].memberAddress,
            partnerAddress: _partnerAddress
        }));
    }

    //recover points
    function recoverPoints (address _oldMemberAddress, address _newMemberAddress) public
        onlyOwner
        isMember(_oldMemberAddress)
        isMember(_newMemberAddress)
    {
        // update member account
        uint oldPoints = members[_oldMemberAddress].points;
        members[_oldMemberAddress].points = 0;
        members[_newMemberAddress].points = oldPoints;

        // add transction
        recoverActions.push(RecoverAction({
            newMemberAddress: _newMemberAddress,
            oldMemberAddress: _oldMemberAddress
        }));
    }

    function getLoyaltyScore(address _member) external view returns (uint) {
        uint256 timespan = getScoreTimespan();
        uint result = 0;

        for (uint i = 0; i < transactionsInfo.length; i++) {
            if (block.timestamp - transactionsInfo[i].timestamp > timespan) {
                continue;
            }

            if (transactionsInfo[i].transactionType == TransactionType.Redeemed)
            {
                continue;
            }

            if (transactionsInfo[i].memberAddress == _member) {
                result = result + transactionsInfo[i].points;
            }
        }
        return result;
    }

    //get length of transactionsInfo array
    function transactionsInfoLength() public view returns(uint256) {
        return transactionsInfo.length;
    }

    //get length of partnersInfo array
    function partnersInfoLength() public view returns(uint256) {
        return partnersInfo.length;
    }
    

    // Future growth to include partner or member information, if and when anonymity is a lesser concern
    
   /* function regBusiness(string memory _bName, string memory _email, address _bAd, string memory _symbol) public {
	//	require(msg.sender == owner);
		require(!customers[_bAd].isReg, "Customer Registered");
		require(!businesses[_bAd].isReg, "Business Registered");
		//pubcoin_points _newcon = new pubcoin_points(_bAd, _bName, _symbol, _decimal); //creates new crypto-token
		businesses[_bAd] = business(_bAd, _bName , _email, true);//creates new business
		pp.mint(_bAd, 100);
		//businesses[_bAd].pp.mint(_bAd, 10000);//gives tokens for the business
    }
    
    function regCustomer(string memory _firstName, string memory _lastName, string memory _email, address _cAd) public {
	//	require(msg.sender == owner);
		require(!customers[_cAd].isReg, "Customer Registered");
		require(!businesses[_cAd].isReg, "Business Registered");
		pp.mint(_cAd, 1000);
		customers[_cAd] = customer(_cAd, _firstName, _lastName, _email, true);
	}
	
	function reward(address _cAd, uint256 _points) public{
		require(businesses[msg.sender].isReg, "This is not a valid business account");
		require(customers[_cAd].isReg, "This is not a valid customer account");
		pp.transferFrom(msg.sender, _cAd, _points);
	}
	
	function spend(address to_bus, uint256 _points) public {
		require(customers[msg.sender].isReg, "This is not a valid customer account");
		require(businesses[to_bus].isReg, "This is not a valid business account");
	
		
		//burn from first account(customer) and mint into the reciever's businesses 
		//burnFrom(msg.sender, _points);
		//pp.burnFrom(msg.sender, _points);
		//pp.mint(to_bus, _points);
		pp.transferFrom(msg.sender, to_bus, _points);
		
		}
		
	function token_add(address _bAd, uint256 _points) public {
	    require(businesses[_bAd].isReg, "This is not a valid business account");
	    pp.mint(_bAd, _points);
	} */
}