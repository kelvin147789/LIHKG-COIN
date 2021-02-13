      {/* RENDERING */}
      <h1>LIHKG COIN</h1>
      <div></div>
       <img src={lihkgIcon} alt="Lihkg Icon"/>


       {/* Connect Metamsk wallet */}

    <div className="metaMaskButton">
    <div>MetaMask Wallet Connect:</div>
    <div>
    <MetaMaskButton className="spacingTop" onClick={ethEnabled,refreshPage}>Connect with Wallet</MetaMaskButton></div>
   
    {account}
  
    <div class="contractAddress">
      LIHKGC Address: 
      </div>
    
      {lihkgCoinAddress}
  
    <div class="balance">
       LIHKGCOIN Balances:
    </div>

  
      {lihkgCoinBalances}


    <div className="stakeAddress"> LIHKGC Stake Address:</div>
    {lihkgcStakeAddress}
    



    <div>
    <div class="buttons">
  <div class="container"onClick={agree5DemandNot1Less} >
      <i class="btn effect04" data-sm-link-text="缺一不可" ><span>五大訴求</span></i>
  </div>
</div>
    </div>

   

    <div>
    <div class="buttons claim-button">
  <div class="container"onClick={claimLIHKGC} >
      <i class="btn effect04" data-sm-link-text="請先同意五大訴求" ><span>Claim LIHKGC</span></i>
  </div>
</div>
    </div>
    {/* {account} */}
    </div>


 {/* RENDERING */}
    