import "./LIHKGCOIN.sol";

// SPDX-License-Identifier: MIT


pragma solidity >=0.4.22 <0.8.0;




contract LIHKGCSTAKE {
  LIHKGCOIN lihkgc;
  constructor(LIHKGCOIN _lihkgcoin) public
  {
      lihkgc = _lihkgcoin;
      owner = msg.sender;
     
  }


      event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    string public name = "LIHKGC Staking";
    address public owner;
    address[] public stakers;

    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;
    mapping(address => uint256) public releaseTime;
    uint256 public constant _TIMELOCK = 5 minutes;
    address public lihkgcoin_address = address(lihkgc);

    // Reward
    mapping (address => uint256) internal rewards;

    

    function getLihkgCoinAddress()public view returns (address)
    {
        return address(lihkgc);
    }

    // Check if address a staker
    function isStaker(address _address) public view returns (bool,uint256)
    {
        for (uint256 i = 0; i < stakers.length;i++)
        {
            if (_address == stakers[i]) return (true,i);
        }
        return (false,0);
    }

    // To allow the contract transfer token from token owner
    function approveStake(address _owner,address _spender , uint256 _amount) public 
        returns (address,uint256)
        {
            lihkgc.approve(_spender,_amount);
            emit Approval(_owner,_spender,_amount);
            return (_spender,_amount);
        }
    


    function addStaker(address _staker,uint256 _amount) public {
        lihkgc.transferFrom(_staker,address(this),_amount);
        stakers.push(_staker);
        stakingBalance[_staker] = stakingBalance[_staker] += _amount;
        releaseTime[msg.sender] = block.timestamp + _TIMELOCK;
    }

    function checkBalanceOf(address _owner) public view returns (uint256) 
    {
        uint256 balances;
        balances = lihkgc.balanceOf(_owner);
        return balances;
    }

    function checkAllowance(address _owner) public view returns (uint256)
    {
       
        uint256 allowances;
        allowances = lihkgc.allowance(_owner,lihkgcoin_address);
        return allowances;
    }

    // Claim staking LIHKGC and remove user in staker
    function removeStaker(address _staker) public {
        (bool _isStakeHolder,uint256 s_o) = isStaker(_staker);
        {
            require(_isStakeHolder);
            require(block.timestamp > releaseTime[_staker], "Your token is still locked");
            require(stakingBalance[msg.sender] > 0, "No LIHKGC awaiting to withdrawl");
            uint256 withdrawlBalances = stakingBalance[msg.sender];
            stakingBalance[msg.sender] = stakingBalance[msg.sender] -= withdrawlBalances;
            lihkgc.transfer(msg.sender,withdrawlBalances);
            stakers[s_o] = stakers[stakers.length -1];
            stakers.pop();
        }
    }


    // check user staking balance
    function stakeOf(address _staker) public view returns (uint256)
    {
        return stakingBalance[_staker];

     }


    //  Reward
    function rewardOf(address _staker) public view returns (uint256)
    {
        return rewards[_staker];
    }

    function calculateReward(address _staker) public view returns (uint256)
    {
        uint256 rewardOfStaker =  stakingBalance[_staker] / 100000 * block.timestamp;
        return rewardOfStaker;

    }

    function distributeRewards() public  {
        require(msg.sender == owner);
        for (uint256 s = 0; s < stakers.length; s+=1)
        {
            address stakeholder = stakers[s];
            uint256 reward = calculateReward(stakeholder);
            rewards[stakeholder] = rewards[stakeholder]+= reward ;
        }
    }


    function withdrawlReward() public {
        uint256 reward = rewards[msg.sender];
        rewards[msg.sender] = 0;
        lihkgc.transfer(msg.sender, reward);
    }



    


}
