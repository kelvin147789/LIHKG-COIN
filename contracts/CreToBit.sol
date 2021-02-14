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
  uint256 public governanceFactor = 10000000000000000;
  uint256 public icoLateRate = 950000000000000000;
  uint256 public icoEnd = block.timestamp + 30 days;

  uint256 public ethtouint256 = 1000000000000000000;
  uint256 public uint256toeth = 1;
  
  address lihkgcoin_address = address(lihkgc);
//   uint256 public testNumber = SafeMath.sub(1, 2);
  uint256 public borrowFactor = 100000000000000000;
  uint256 public timelock = 2 minutes;
  mapping (address => uint256) public nextAvailablePayBackTime;



 
 
  

  

  

  
  
  
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
      require(msg.sender == owner && block.timestamp > icoEnd);
      uint256 burnToken = balances[address(this)];
      totalSupply_ = totalSupply_ -= burnToken;
      emit Burn (address(this),burnToken);
      emit Transfer(address(this),address(0),burnToken);

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
      nextAvailablePayBackTime[_address] + timelock;
  }

  function paybackETH(address payable _address,uint256 _amount) payable public {
      require(block.timestamp > nextAvailablePayBackTime[_address]);
      
      _address.transfer(_amount);
  }

  function adjustDebitFactor(uint256 _amount) public payable{
      require(lihkgc.balanceOf((msg.sender)) >= lihkgc.balanceOf(lihkgcoin_address) * governanceFactor);
      debitFactor == _amount;
  }

  function adjustCrebitFactor(uint256 _amount) public payable{
      require(lihkgc.balanceOf((msg.sender)) >= lihkgc.balanceOf(lihkgcoin_address) * governanceFactor);
      creditFactor == _amount;
  }




  function transfer(address receiver, uint numTokens) public returns (bool) {
       require(numTokens <= balances[msg.sender]);
       balances[msg.sender] = balances[msg.sender]-=numTokens;
       balances[receiver] = balances[receiver]+=numTokens;
       emit Transfer(msg.sender, receiver, numTokens);
       return true;
   }

  

    


}



 

