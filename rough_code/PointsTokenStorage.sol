
pragma solidity >=0.5.8;

/**
 * Title PointsTokenStorage
 * This contract holds all the necessary state variables to carry out the storage of any contract.
 */
 import "./Pubcoin.sol";
contract PointsTokenStorage {

 // model a member
    struct Member {
        address memberAddress;
        uint points;
        bool isRegistered;
        string memberName;
        pubcoin mP;
    }

    // model a partner
    struct Partner {
        address partnerAddress;
        bool isRegistered;
        string partnerName;
        pubcoin mP;
        
    }

    // model points transaction
    enum TransactionType {
        Earned,
        Redeemed
    }

    struct PointsTransaction {
        uint timestamp;
        uint points;
        TransactionType transactionType;
        address memberAddress;
        address partnerAddress;
    }

    struct RecoverAction {
        address newMemberAddress;
        address oldMemberAddress;
    }
        struct customer {
        address customer_id;
        string first_name;
        string last_name;
        string email;
        bool isReg;
        mapping (address => bool) bus;
    }
    
    struct business {
        address business_id;
        string business_name;
        string email;
        bool isReg;
        //uint256 points;
        // pubcoin pp;
        mapping(address => bool) cust;
        mapping(address => bool) partnership;
        mapping(address => uint256) xrate;
    }

   mapping(address => Member) public members;

    mapping(address => Partner) public partners;
    
    mapping(bytes32 => address) internal addressStorage;
    
    mapping(bytes32 => bool) internal boolStorage;

    mapping(bytes32 => uint256) internal uintStorage;
        
    mapping(address => customer) public customers;
	mapping(address => business) public businesses;

    //public transactions and partners information
    Partner[] public partnersInfo;

    PointsTransaction[] public transactionsInfo;

    RecoverAction[] public recoverActions;

}