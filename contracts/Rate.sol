pragma solidity ^0.4.18;

contract Rate {
    struct Rating {
        uint id;
        uint userRatingId;
        bytes32 trxId;
        uint stars;
        string review;
    }
    
    address public owner;
    uint public ratingIdCounter;
    mapping(address => mapping(bytes32 => Rating)) public ratings;
    mapping(address => uint) public userRatingIdCounters;
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    function Rate() public {
        owner = msg.sender;
    }
    
    function rate(string trxId, uint stars, string review) public {
        var key = keccak256(trxId);
        Rating storage rating = ratings[msg.sender][key];
        
        require(stars >= 1 && stars <= 5);
        require(bytes(review).length <= 5000);
        
        rating.id = ++ratingIdCounter;
        rating.userRatingId = ++userRatingIdCounters[msg.sender];
        rating.stars = min(stars, 5);
        rating.review = review;
    }
    
    function getRating(address sender, string trxId) view public returns (uint id, uint stars, string review){
        var key = keccak256(trxId);
        var rating = ratings[sender][key];
        
        id = rating.id;
        stars = rating.stars;
        review = rating.review;
    }

    function min(uint a, uint b) pure public returns (uint _min) {
        if (a > b)
            return b;
        else
            return a;
    }
    
    function divCeil(uint a, uint b) pure public returns (uint result) {
        result = a / b;
        if ((result * b) < a){
            result++;
        }
    }
}