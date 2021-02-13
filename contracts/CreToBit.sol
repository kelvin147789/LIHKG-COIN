pragma solidity >=0.4.22 <0.8.0;
// SPDX-License-Identifier: MIT

import "./LIHKGCOIN.sol";

contract CreToBit 
{
    LIHKGCOIN lihkgc;

    // supply according to ico eth ,all remaining would be burn

    // LIHKGC as governance token

   

  address public owner;
  string public name = "CreToBit";
  
  mapping(address=> uint256) public depositedCTB;
  mapping(address=> uint256) public depositedETH;
  uint256 public debitFactor = 900000000000000000;
  uint256 public creditFactor = 1100000000000000000;
  uint256 public governanceFactor = 10000000000000000;

  uint256 public ethtouint256 = 1000000000000000000;
  uint256 public uint256toeth = 1;
  
  address lihkgcoin_address = address(lihkgc);
  

  

  

  
  
  
 constructor(LIHKGCOIN _lihkgcoin) public
  {
      lihkgc = _lihkgcoin;
      owner = msg.sender;  
      
  }

  function totalETH() public view returns (uint256)
    {   
       
        // return totalDepositedETH;
    }

  
  
 

  function borrowETH(address payable _address,uint256 _amount,address payable ctbAddress) payable external{
  }

  function paybackETH(address payable _address,uint256 _amount) payable public {
  }

  function adjustDebitFactor(uint256 _amount) public payable{
      require(lihkgc.balanceOf((msg.sender)) >= lihkgc.balanceOf(lihkgcoin_address) * governanceFactor);
      debitFactor == _amount;
  }

  function adjustCrebitFactor(uint256 _amount) public payable{
      require(lihkgc.balanceOf((msg.sender)) >= lihkgc.balanceOf(lihkgcoin_address) * governanceFactor);
      creditFactor == _amount;
  }

  

    


}