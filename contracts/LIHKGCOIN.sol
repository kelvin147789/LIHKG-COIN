// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;



contract LIHKGCOIN {
  string public constant name = "Lihkgcoin";
  string public constant symbol = "LIHKGC";
  uint8 public constant decimals = 18;
 
   string public fiveDemandsNotOneLessStatement= "1.Complete withdrawal of the extradition bill from the legislative process 2.Retraction of the riot characterisation 3.Release and exoneration of arrested protesters 4.Establishment of an independent commission of inquiry into police conduct and use of force during the protests 5.Resignation of Carrie Lam and the implementation of universal suffrage for Legislative Council elections and for the election of the chief executive";
 
 
 
   event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
   event Transfer(address indexed from, address indexed to, uint tokens);
 
 
   mapping(address => uint256) balances;
 
   mapping (address => bool) fiveDemandsNotOneLess;
   mapping (address => bool) claimed;
 
   mapping(address => mapping (address => uint256)) allowed;
  
   uint256 totalSupply_ = 2000001000000000000000000;

   uint256 claimReward = 7000000000000000000;
 
   using SafeMath for uint256;
 
  
  constructor() public { 
   totalSupply_ = totalSupply();
   balances[msg.sender] = 1000000000000000000000000;
   
   
   } 
 
 
 
   function agreeStatement() public  returns (bool)
   {
       address user;
       user = msg.sender;
       fiveDemandsNotOneLess[user] = true;
      
   }
 
   function claimLIHKGC() public  payable returns (bool)
   {
    require(fiveDemandsNotOneLess[msg.sender] == true && claimed[msg.sender] == false);
    balances[msg.sender] += claimReward;
    emit Transfer(address(this), msg.sender, claimReward);
    claimed[msg.sender] = true;
   }
 
 
 
   function totalSupply() public view returns (uint256) {
   return totalSupply_;
   }
  
   function balanceOf(address tokenOwner) public view returns (uint) {
       return balances[tokenOwner];
   }
 
   function transfer(address receiver, uint numTokens) public returns (bool) {
       require(numTokens <= balances[msg.sender]);
       balances[msg.sender] = balances[msg.sender].sub(numTokens);
       balances[receiver] = balances[receiver].add(numTokens);
       emit Transfer(msg.sender, receiver, numTokens);
       return true;
   }
 
   function approve(address delegate, uint numTokens) public returns (bool) {
       allowed[msg.sender][delegate] = numTokens;
       emit Approval(msg.sender, delegate, numTokens);
       return true;
   }
 
   function allowance(address owner, address delegate) public view returns (uint) {
       return allowed[owner][delegate];
   }
 
   function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
       require(numTokens <= balances[owner]);   
       require(numTokens <= allowed[owner][msg.sender]);
  
       balances[owner] = balances[owner].sub(numTokens);
       allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
       balances[buyer] = balances[buyer].add(numTokens);
       emit Transfer(owner, buyer, numTokens);
       return true;
   }
 
 
}
 
library SafeMath {
   function sub(uint256 a, uint256 b) internal pure returns (uint256) {
     assert(b <= a);
     return a - b;
   }
  
   function add(uint256 a, uint256 b) internal pure returns (uint256) {
     uint256 c = a + b;
     assert(c >= a);
     return c;
   }

   function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

}
