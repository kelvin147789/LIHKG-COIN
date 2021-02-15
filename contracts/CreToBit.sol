pragma solidity >=0.4.22 <0.8.0;
// SPDX-License-Identifier: MIT

import "./LIHKGCOIN.sol";

contract CreToBit 
{
    LIHKGCOIN lihkgc;

    // supply according to ico eth ,all remaining would be burn

    // LIHKGC as governance token

 event Transfer(address indexed from, address indexed to, uint tokens);
 event Burn(address indexed burner, uint256 value);
 event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

  address public owner;
  string public name = "CreToBit";
  string public constant symbol = "CTB";
  uint8 public constant decimals = 18;

  uint256 totalSupply_ = 1000000000000000000000;

  mapping (address=> uint256) public balances;
  mapping(address=> uint256) public depositedCTB;
  mapping(address=> uint256) public depositedETH;
  uint256 public debitFactor = 900000000000000000;
  uint256 public creditFactor = 1100000000000000000;
  uint256 public governanceFactor = 500000000000000000;
  uint256 public icoLateRate = 950000000000000000;
  uint256 public icoEnd = block.timestamp + 30 days;
  uint256 public totalDepositedCTB;
  uint256 public totalDepositedETH;

  uint256 public ethtouint256 = 1000000000000000000;
  uint256 public uint256toeth = 1;
  
  address lihkgcoin_address = address(lihkgc);
//   uint256 public testNumber = SafeMath.sub(1, 2);
  uint256 public borrowFactor = 100000000000000000;
  uint256 public boostBorrowFactorIndex = 500000000000000000;
  uint256 public boostBorrowFactor2x = 2000000000000000000;
  uint256 public preboostOffsetFactor = 900000000000000000;
  uint256 public timelock = 2 minutes;
  mapping (address => uint256) public nextAvailablePayBackTime;

  mapping(address => mapping (address => uint256)) allowed;

  





 
 
  

  

  

  
  
  
 constructor(LIHKGCOIN _lihkgcoin) public
  {
      totalSupply_ = totalSupply();
      lihkgc = _lihkgcoin;
      owner = msg.sender;
      balances[msg.sender] = 100000000000000000000;
      
      
  }

  function icoCTB() payable public {
      uint256 amountToBuy = msg.value;
      uint256 contractBalance = CreToBit.balanceOf(address(this));
      require(amountToBuy > 0 && amountToBuy <= contractBalance, "You need to send ether or ico end");
      if (contractBalance > 500)
      {
          CreToBit.transfer(msg.sender, amountToBuy);
      }

      CreToBit.transfer(msg.sender, amountToBuy * icoLateRate);

  }

  function icoBurn() public  {
      require(msg.sender == owner || block.timestamp > icoEnd);
      uint256 burnTokenAmount = balances[address(this)];
      totalSupply_ = totalSupply_ -= burnTokenAmount;
      emit Burn (address(this),burnTokenAmount);
      emit Transfer(address(this),address(0),burnTokenAmount);

  }

  function burnToken(uint256 _amount) public {
      require(msg.sender == owner);
      emit Burn (msg.sender,_amount);
      emit Transfer(msg.sender, address(0), _amount);
  }

  function totalETH() public view returns (uint256)
    {   
        // return totalDepositedETH;
        return address(this).balance;
    }

   function totalSupply() public view returns (uint256) 
   {
        return totalSupply_;
   }

  

  
  
 function balanceOf(address tokenOwner) public view returns (uint) {
       return balances[tokenOwner];
   }

  function borrowETH(address payable _address,uint256 _amount,address payable ctbAddress) payable external{
      require(depositedCTB[_address] <= 0 && depositedETH[_address] >= 0);
      nextAvailablePayBackTime[_address] = nextAvailablePayBackTime[_address] += timelock;
      CreToBit.transfer(address(this), _amount);
      depositedCTB[_address] += _amount;
      totalDepositedCTB += _amount;
      uint256 actualWithdrawlETH = _amount * debitFactor;
    // CTB  Address transfer ETH to msg.sender 
      ctbAddress.transfer(actualWithdrawlETH);
      depositedETH[_address] -= actualWithdrawlETH;
      totalDepositedETH -= actualWithdrawlETH;

  }

  function paybackETH(address payable _address,uint256 _amount) payable public {
      uint256 depositETH = _amount;
      require(block.timestamp > nextAvailablePayBackTime[_address] && depositETH >= depositedCTB[msg.sender] * creditFactor && depositedCTB[msg.sender] > 0);
    //   msg.sender transfer eth to contract
      msg.sender.transfer(depositETH);
      depositedETH[_address] += depositETH;
      totalDepositedETH += depositETH;
      CreToBit.transfer(_address, depositETH);
      depositedCTB[_address] -= depositETH;
      totalDepositedCTB -= depositETH;


      
      
      _address.transfer(_amount);
  }

  function adjustDebitFactor(uint256 _amount) public payable{
      require(lihkgc.balanceOf((msg.sender)) >= lihkgc.balanceOf(lihkgcoin_address) * governanceFactor || msg.sender == owner);
      debitFactor == _amount;
  }

  function adjustCrebitFactor(uint256 _amount) public payable{
      require(lihkgc.balanceOf((msg.sender)) >= lihkgc.balanceOf(lihkgcoin_address) * governanceFactor || msg.sender == owner);
      creditFactor == _amount;
  }

  function boostBorrowFactor() public {
      require(msg.sender == owner && totalDepositedETH * boostBorrowFactorIndex >= totalDepositedCTB * borrowFactor * preboostOffsetFactor);
      borrowFactor = borrowFactor * boostBorrowFactor2x;
      mint(totalSupply_);
  }




  function transfer(address receiver, uint numTokens) public returns (bool) {
       require(numTokens <= balances[msg.sender]);
       balances[msg.sender] = balances[msg.sender]-=numTokens;
       balances[receiver] = balances[receiver]+=numTokens;
       emit Transfer(msg.sender, receiver, numTokens);
       return true;
   }

   function mint(uint256 amount) public {
    require(msg.sender == owner);
    require(totalSupply_ + amount >= totalSupply_); // Overflow check

    totalSupply_ += amount;
    balances[address(this)] += amount;
    emit Transfer(address(0), address(this), amount);
}

    function approve(address delegate, uint numTokens) public returns (bool) {
       allowed[msg.sender][delegate] = numTokens;
       emit Approval(msg.sender, delegate, numTokens);
       return true;
   }


   function transferFrom(address _owner, address buyer, uint numTokens) public returns (bool) {
       require(numTokens <= balances[_owner]);   
       require(numTokens <= allowed[_owner][msg.sender]);
  
       balances[_owner] = balances[_owner]-= numTokens;
       allowed[_owner][msg.sender] = allowed[_owner][msg.sender] -= numTokens;
       balances[buyer] = balances[buyer] += numTokens;
       emit Transfer(_owner, buyer, numTokens);
       return true;
   }


      

}








 

