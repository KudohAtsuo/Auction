pragma solidity ^0.4.21;

// auction contract
// highest bidder cannot withdraw
contract Auction{
  address public highestBidder;
  uint public highestBid;

  // address to value to withdraw
  mapping(address => uint) public bidder;
  uint numBidders;

  //constructor
  function Auction() public{
    numBidders = 0;
  }

  // to bid
  function bid(uint _value) public payable{
    require(_value > 0 && _value > bidder[highestBidder]);

    highestBidder = msg.sender;
    bidder[highestBidder] = _value;
    highestBid = _value;
    numBidders++;
  }

  // to withdraw
  function whthdraw(address _addr) public onlyBidder(_addr){
    require(bidder[_addr] > 0 && highestBidder != _addr);

    _addr.transfer(bidder[_addr]);
    bidder[_addr] = 0;
  }

  modifier onlyBidder(address _addr){
    require(msg.sender == _addr);
    _;
  }
}
