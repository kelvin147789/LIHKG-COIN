pragma solidity >=0.4.22 <0.8.0;
// SPDX-License-Identifier: MIT

import "./LIHKGCOIN.sol";

contract CTB 
{
    LIHKGCOIN lihkgc;

   

  address public owner;
  
  mapping(address=> uint256) public depositedCTB;
  mapping(address=> uint256) public depositedETH;
  uint256 public debitFactor = 900000000000000000;
  uint256 public creditFactor = 1100000000000000000;
  uint256 public governanceFactor = 10000000000000000;
  address lihkgcoin_address = address(lihkgc);
  
 constructor(LIHKGCOIN _lihkgcoin) public
  {
      lihkgc = _lihkgcoin;
      owner = msg.sender;
     
     
  }
  
  

  function returnLIHKGC()public view returns (uint256)
    {
        uint256 amountOFLIHKG = lihkgc.balanceOf(address(this));
        return amountOFLIHKG;
    }

  function borrowETH(address payable _address,uint256 _amount,address payable ctbAddress) payable external{
      
      require(lihkgc.balanceOf(_address) > 0 && depositedETH[_address] >= 0 );
      lihkgc.transfer(address(this), _amount);
      depositedCTB[_address] += _amount;
      ctbAddress.transfer(_amount * debitFactor);
      depositedETH[_address] -= _amount;
  }

  function paybackETH(address payable _address,uint256 _amount) payable public {
      require(_amount >= depositedETH[_address] * creditFactor,"Please deposit enough ETH,1.1 * orginalCTB") ;
      _address.transfer(_amount);
      depositedETH[_address] += _amount;
      lihkgc.transfer(_address, _amount);
      depositedCTB[msg.sender] -= _amount;
      
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